# Make use of workload identity to allow pods to authenticate with Google Cloud API
# https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity

# Enabling required google iam credentials api
resource "google_project_service" "project" {
  project = data.terraform_remote_state.projects.outputs.kube_project_id
  service = "iamcredentials.googleapis.com"

  disable_dependent_services = true
}

# Service account
resource "google_service_account" "gke-db-backup" {
  account_id   = "gke-db-backup"
  display_name = "GKE Database Backup Service Account"
  project      = data.terraform_remote_state.projects.outputs.kube_project_id
}

# Custom role to authorize creating objects on cloud storage
resource "google_project_iam_custom_role" "gke-db-backup-role" {
  role_id     = "CustomDbBackup"
  title       = "GKE DB Backup role"
  description = "Role to be able to backup a database and push it to cloud storage"
  project     = data.terraform_remote_state.projects.outputs.kube_project_id
  permissions = [
    "storage.objects.list",
    "storage.objects.create",
    "storage.objects.delete",
  ]
}

# Bindings to SA
resource "google_project_iam_binding" "project" {
  project = data.terraform_remote_state.projects.outputs.kube_project_id
  role    = google_project_iam_custom_role.gke-db-backup-role.id

  members = [
    "serviceAccount:${google_service_account.gke-db-backup.email}",
  ]
}

# k8s binding so that k8s SA db/mysql can impersonate the SA
resource "google_service_account_iam_binding" "gke-db-backup-k8s-binding" {
  service_account_id = google_service_account.gke-db-backup.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${data.terraform_remote_state.projects.outputs.kube_project_id}.svc.id.goog[db/mysql]",
  ]
}
