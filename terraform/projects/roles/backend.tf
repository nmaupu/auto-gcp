terraform {
  backend "gcs" {
    bucket  = "nma-terraform"
    prefix  = "roles.tfstate"
  }

  required_version = ">= 0.12"
}
