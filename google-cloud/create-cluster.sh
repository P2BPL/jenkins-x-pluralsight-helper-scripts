#!/bin/bash
set -e

if [ -z "$GCP_PROJECT" ]
then
  echo "Please enter the name of your GCP project"
  read GCP_PROJECT
fi

export GCP_PROJECT

echo Setting gcloud project to ${GCP_PROJECT}

gcloud config set project ${GCP_PROJECT}

echo Enabling k8s API in project ${GCP_PROJECT} to work around Terraform race condition...

gcloud services enable container.googleapis.com

GCLOUD_USER=$(gcloud config list account --format "value(core.account)" 2> /dev/null)
echo Detected current gcloud user as ${GCLOUD_USER}

echo Making sure ${GCLOUD_USER} has the roles roles/owner and roles/storage.admin, as they are required by Terraform
gcloud projects add-iam-policy-binding ${GCP_PROJECT} --member user:${GCLOUD_USER} --role roles/owner
gcloud projects add-iam-policy-binding ${GCP_PROJECT} --member user:${GCLOUD_USER} --role roles/storage.admin

cd terraform
terraform init
TF_VAR_gcp_project="${GCP_PROJECT}" terraform apply
cd ../../jx-boot-configs
rm -rf "environment-${GCP_PROJECT}-dev"
git clone git@github.com:jenkins-x/jenkins-x-boot-config.git "environment-${GCP_PROJECT}-dev"

cd "environment-${GCP_PROJECT}-dev"
cp ../../google-cloud/terraform/jx-requirements.yml jx-requirements.yml
jx boot