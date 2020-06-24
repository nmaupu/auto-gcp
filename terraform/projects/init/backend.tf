provider "google" {
  region = var.region
}

terraform {
  backend "gcs" {
    bucket  = "nma-terraform"
    prefix  = "projects.tfstate"
  }

  required_version = ">= 0.12"
}

