#!/bin/bash
set -e

cd terraform
TF_VAR_gcp_project="${GCP_PROJECT}" terraform destroy