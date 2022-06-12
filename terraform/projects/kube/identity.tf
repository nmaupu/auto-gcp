# Make use of workload identity to allow pods to authenticate with Google Cloud API
# https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity

# Enabling required google iam credentials api
resource "google_project_service" "project" {
  project = data.terraform_remote_state.projects.outputs.kube_project_id
  service = "iamcredentials.googleapis.com"

  disable_dependent_services = true
}
