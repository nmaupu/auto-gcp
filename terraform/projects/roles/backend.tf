terraform {
  backend "gcs" {
    bucket  = "nma-terraform"
    project = "nma-terraform"
    prefix  = "roles.tfstate"
  }

  required_version = "= 0.11.1"
}
