##
# Getting corresponding project
##
data "terraform_remote_state" "projects" {
  backend = "gcs"

  config = {
    bucket = "nma-terraform"
    prefix = "projects.tfstate"
    #project = "nma-terraform"
  }
}

##
# Available zones for kubernetes cluster
##
#data "google_compute_zones" "available" {}
