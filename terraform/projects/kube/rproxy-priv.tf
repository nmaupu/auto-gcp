resource "google_compute_disk" "rproxy-priv-certs" {
  project = "${data.terraform_remote_state.projects.kube.project_id}"
  name    = "rproxy-priv-certs"
  type    = "pd-standard"
  zone    = "${data.google_compute_zones.available.names[0]}"
  size    = "1"
}

resource "google_compute_address" "rproxy-priv-addr" {
  name = "rproxy-priv-addr"
}

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

  access_config = {
    nat_ip = "${google_compute_address.rproxy-priv-addr.address}"
  }

  attached_disk_source      = "${google_compute_disk.rproxy-priv-certs.self_link}"
  attached_disk_device_name = "${google_compute_disk.rproxy-priv-certs.name}"
  startup_script            = "${file("scripts/detect-disk.sh")}"

  # See for scopes' list:
  # https://developers.google.com/identity/protocols/googlescopes
  service_account_scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/compute.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
  ]
}
