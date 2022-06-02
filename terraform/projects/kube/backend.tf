terraform {
  backend "gcs" {
    bucket = "nma-terraform"
    prefix = "kube.tfstate"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  region = var.region
}
