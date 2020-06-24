provider "google" {
  region = var.region
}

terraform {
  backend "gcs" {
    bucket  = "nma-terraform"
    prefix  = "kube.tfstate"
  }
}

