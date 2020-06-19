#!/bin/bash
set -e

cd terraform
terraform init
terraform apply
VAULT_AWS_ACCESS_KEY_ID=$(terraform output vault_user_id)
VAULT_AWS_SECRET_ACCESS_KEY=$(terraform output vault_user_secret)

cd ../..

if [[ ! -d environment-ps-jx-cluster-dev ]]
then
    echo "You don't currently have a jx boot git repo, so creating one."
    git clone git@github.com:jenkins-x/jenkins-x-boot-config.git environment-ps-jx-cluster-dev
else
    echo "Re-using the existing jx boot git repo"
fi

cd environment-ps-jx-cluster-dev
cp ../aws/terraform/jx-requirements.yml jx-requirements.yml

export VAULT_AWS_ACCESS_KEY_ID
export VAULT_AWS_SECRET_ACCESS_KEY

JX_VALUE_PIPELINEUSER_USERNAME="jenkins-x-pipeline-bot" jx boot