module "rproxy-priv-instance" {
  source       = "../../modules/compute/instance"
  project      = "${data.terraform_remote_state.projects.kube.project_id}"
  name         = "${var.rproxy_priv_name}"
  machine_type = "${var.rproxy_priv_machine_type}"
  zone         = "${data.google_compute_zones.available.names[0]}"
  tags         = ["rproxy-priv"]
  image        = "${var.rproxy_image_priv}"
  subnetwork   = "${module.subnetwork.self_link}"
  preemptible  = "${var.rproxy_priv_preemptible}"
  automatic_restart = "false"

  service_account_scopes = [
    "userinfo-email",
    "compute-ro",
    "storage-ro",
  ]
}

resource "google_compute_firewall" "rproxy-priv-rules" {
  name    = "rproxy-priv-http"
  network = "${module.network.self_link}"

  source_ranges = ["${var.rproxy_priv_sources}"]

  allow {
    protocol = "tcp"
    ports    = ["${var.rproxy_allow_ports}"]
  }

  target_tags = ["rproxy-priv"]
  project     = "${data.terraform_remote_state.projects.kube.project_id}"
}
