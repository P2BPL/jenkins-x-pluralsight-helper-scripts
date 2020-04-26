#!/bin/bash
set -e

cd terraform
terraform destroy

rm -rf ps-jx-cluster-boot-config
git clone git@github.com:jenkins-x/jenkins-x-boot-config.git ps-jx-cluster-boot-config