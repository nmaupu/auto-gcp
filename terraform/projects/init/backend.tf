provider "google" {
  region = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket  = "nma-terraform"
    project = "nma-terraform"
    prefix  = "projects.tfstate"
  }

  required_version = "= 0.11.1"
}
