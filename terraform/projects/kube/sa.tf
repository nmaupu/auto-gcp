resource "google_service_account" "wp-stateless" {
  account_id   = "wp-stateless"
  display_name = "Wordpress plugin for storage on GCS"
  project      = "${data.terraform_remote_state.projects.kube.project_id}"
}

resource "google_organization_iam_binding" "wp-stateless-binding" {
  org_id = "${var.org_id}"
  role   = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.wp-stateless.email}",
  ]
}
