# Jenkins X Pluralsight Helper Scripts
# Added my comment
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

- `jx`  command = curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-linux-amd64.tar.gz" | tar xzv "jx" 

sudo mv jx /usr/local/bin


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

To Downsize :

[200~gcloud container clusters resize bm-jx-cluster --num-nodes=0 --zone us-central1-a
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

## AWS

### Pre-requisites

- `jx` 
- `helm` **version 2**
- `kubectl` 
- `aws` 
- `aws-iam-authenticator` 
- `wget` 
- You have run `aws configure` to set up your credentials for running Terraform. 
Make sure the region is the same as the Terraform project, `us-east-1`. You can change 
it if you like, just make sure they match.
- If this a new AWS account, run `aws iam create-service-linked-role --aws-service-name "elasticloadbalancing.amazonaws.com"`. 
If it fails because it hasn't aleady been executed then don't worry

### How to execute

To create a cluster run:

`./create-cluster.sh`

The script will create a k8s cluster using Terraform followed by `jx boot` to 
install Jenkins X. You will get some prompts on 
the command line both from `terraform apply` and `jx boot` which
are explained in module 3.

To destroy your cluster run:

`./destroy-cluster.sh`

Destroying really will destroy all your infrastructure, even buckets with
backups of your Jenkins X installation. Because of this you should manually
delete the `environment-ps-jx-cluster-dev` repository from your GitHub account.
That way if you create again you will get a clean slate and a new repo. Re-using 
the existing one after recreating the infrastructure could cause errors.

### Troubleshooting Terraform

Sometimes Terraform can be flaky, either with unexpected errors or timeouts, which 
are not really solvable given the way it interacts with the cloud provider API. If 
you see an error, you can try re-running the script, and it should fix the problem most of the time.
