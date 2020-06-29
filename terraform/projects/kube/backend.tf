provider "google" {
  region = var.region
  version = "~> 3.27"
}

terraform {
  backend "gcs" {
    bucket = "nma-terraform"
    prefix = "kube.tfstate"
  }
}

