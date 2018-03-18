resource "google_storage_bucket" "default" {
  project  = "${var.project}"
  name     = "${var.name}"
  location = "${var.location}"
  storage_class = "${var.storage_class}"

  versioning = {
    enabled = "${var.versioning}"
  }

  lifecycle_rule = "${var.lifecycle_rule}"
}
