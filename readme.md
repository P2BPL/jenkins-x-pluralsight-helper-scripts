# Jenkins X Pluralsight Helper Scripts

This project contains helper scripts for creating a Jenkins X Cluster 
for the Pluralsight Jenkins X Course as easily as possible. Currently only Google Cloud and 
AWS are supported, but it can be expanded in the future.

**This does not create a production ready cluster**. Instead it's 
designed to be the simplest way of getting something up and running
for demo purposes. Therefore it has been designed to cut as many corners 
as possible in order for your to execute it with minimal setup and configuration.

To productionize it, you can look at modifying it so:

- Terraform and it's state file are remote
- Configured to use TLS and your own custom domain
- Pin the Terraform module version
- Check out the  Pluralsight course for more information  

## Google Cloud

### Pre-requisites

- `jx` 
- `helm` **version 2**
- `gcloud`
- `kubectl` installed via `gcloud`
- You are logged in as a user via `gcloud auth application-default`
- You've created a GCP project which will contain the cluster

### How to execute

To create a cluster run:

`GCP_PROJECT=your-gcp-project-name ./create-cluster.sh`

The script will set up your gcloud config, and then it will 
create a k8s cluster using Terraform followed by `jx boot` to 
install Jenkins X. You will get some prompts on 
the command line both from `terraform apply` and `jx boot` which
are explained in module 3.

To destroy your cluster run:

`GCP_PROJECT=your-gcp-project-name ./destroy-cluster.sh`

Destroying really will destroy all your infrastructure, even buckets with
backups of your Jenkins X installation. Because of this you should manually
delete the `environment-ps-jx-cluster-dev` repository from your GitHub account.
That way if you create again you will get a clean slate and a new repo. Re-using 
the existing one after recreating the infrastructure could cause errors.

### Troubleshooting Terraform

Sometimes Terraform can be flaky, either with unexpected errors or timeouts, which 
are not really solvable given the way it interacts with the cloud provider API. If 
you see an error, you can try re-running the script, and it should fix the problem most of the time.