module "rproxy-pub-instance" {
  source       = "../../modules/compute/instance"
  project      = "${data.terraform_remote_state.projects.kube.project_id}"
  name         = "${var.rproxy_pub_name}"
  machine_type = "${var.rproxy_pub_machine_type}"
  zone         = "${data.google_compute_zones.available.names[0]}"
  tags         = ["rproxy-pub"]
  image        = "${var.rproxy_image_pub}"
  subnetwork   = "${module.subnetwork.self_link}"
  preemptible  = "${var.rproxy_pub_preemptible}"

  service_account_scopes = [
    "userinfo-email",
    "compute-ro",
    "storage-ro",
  ]
}
