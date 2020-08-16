variable "gcp_project" {
  type = string
  description = "The name of the Google Cloud Project where you wish to create the cluster"
}

module "jx" {
  source  = "jenkins-x/jx/google"
  gcp_project = var.gcp_project
  cluster_name = "bm-jx-cluster"
  force_destroy = true
}
