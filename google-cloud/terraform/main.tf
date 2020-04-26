variable "gcp_project" {
  type = string
  description = "The name of the Google Cloud Project where you wish to create the cluster"
}

variable "cluster_name" {
  type = string
  description = "The name of the Jenkins X cluster"
  default = "ps-jx-cluster"
}

module "jx" {
  source  = "jenkins-x/jx/google"
  gcp_project = var.gcp_project
  cluster_name = var.cluster_name
  force_destroy = true
}