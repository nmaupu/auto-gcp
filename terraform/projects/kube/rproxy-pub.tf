resource "google_compute_disk" "rproxy-pub-certs" {
  project = data.terraform_remote_state.projects.outputs.kube_project_id
  name    = "rproxy-pub-certs"
  type    = "pd-standard"
  zone    = "europe-west1-b"
  size    = "1"
}

resource "google_compute_address" "rproxy-pub-addr" {
  name         = "rproxy-pub-addr"
  network_tier = var.rproxy_pub_network_tier
  project      = data.terraform_remote_state.projects.outputs.kube_project_id
}

module "rproxy-pub-instance" {
  source              = "../../modules/compute/instance"
  project             = data.terraform_remote_state.projects.outputs.kube_project_id
  name                = var.rproxy_pub_name
  machine_type        = var.rproxy_pub_machine_type
  zone                = "europe-west1-b"
  tags                = ["rproxy-pub"]
  image               = var.rproxy_image_pub
  subnetwork          = module.subnetwork.self_link
  preemptible         = var.rproxy_pub_preemptible
  on_host_maintenance = var.rproxy_pub_on_host_maintenance
  access_config = {
    nat_ip       = google_compute_address.rproxy-pub-addr.address
    network_tier = var.rproxy_pub_network_tier
  }

  attached_disk_source      = google_compute_disk.rproxy-pub-certs.self_link
  attached_disk_device_name = google_compute_disk.rproxy-pub-certs.name
  startup_script            = file("scripts/detect-disk.sh")

  # See for scopes' list:
  # https://developers.google.com/identity/protocols/googlescopes
  service_account_scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/compute.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
  ]
}
