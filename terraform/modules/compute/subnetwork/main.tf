resource "google_compute_subnetwork" "default" {
  name          = var.name
  network       = var.network
  ip_cidr_range = var.ip_cidr_range
  project       = var.project
}

