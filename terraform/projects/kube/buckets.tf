resource "google_storage_bucket" "default" {
  name          = var.backup_bucket_name
  location      = var.region
  storage_class = var.backup_bucket_storage_class
  project = data.terraform_remote_state.projects.outputs.kube_project_id

  versioning {
    enabled = false
  }

  # Delete objects older than lifecycle_condition_age days
  lifecycle_rule {
      condition {
          age        = var.lifecycle_condition_age
          with_state = "LIVE"
        }

      action {
          type = "Delete"
        }
  }
}
