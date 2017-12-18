resource "google_compute_network" "default" {
  name                    = "${var.name}"
  auto_create_subnetworks = "false"
  project                 = "${var.project}"
}
