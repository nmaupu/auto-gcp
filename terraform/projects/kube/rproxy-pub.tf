module "rproxy-pub-instance" {
  source       = "../../modules/compute/instance"
  project      = "${data.terraform_remote_state.projects.kube.project_id}"
  name         = "${var.rproxy_pub_name}"
  machine_type = "${var.rproxy_pub_machine_type}"
  zone         = "${data.google_compute_zones.available.names[0]}"
  tags         = ["rproxy-pub"]
  image        = "${var.rproxy_image_pub}"
  subnetwork   = "${module.subnetwork.self_link}"
  preemptible  = "false"

  service_account_scopes = [
    "userinfo-email",
    "compute-ro",
    "storage-ro",
  ]
}

resource "google_compute_firewall" "rproxy-pub-rules" {
  name    = "rproxy-http"
  network = "${module.network.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["${var.rproxy_allow_ports}"]
  }

  target_tags = ["rproxy-pub"]
  project     = "${data.terraform_remote_state.projects.kube.project_id}"
}
