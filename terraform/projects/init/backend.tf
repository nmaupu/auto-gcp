terraform {
  backend "gcs" {
    bucket  = "nma-terraform"
    prefix  = "projects.tfstate"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.23.0"
    }
  }

  required_version = "= 1.1.2"
}

provider "google" {
  region = var.region
}
