resource "google_project_service" "project_service" {
  project = var.project_id
  service = var.service
}

