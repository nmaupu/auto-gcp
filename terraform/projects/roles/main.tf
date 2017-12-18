variable "org_id" {}
variable "main_user_account" {}

resource "google_organization_iam_binding" "binding" {
  org_id = "${var.org_id}"
  role   = "roles/compute.viewer"

  members = [
    "user:${var.main_user_account}",
  ]
}
