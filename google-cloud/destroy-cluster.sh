#!/bin/bash
set -e

if [ -z "$GCP_PROJECT" ]
then
  echo "Please enter the name of your GCP project"
  read GCP_PROJECT
fi

cd terraform
TF_VAR_gcp_project="${GCP_PROJECT}" terraform destroy