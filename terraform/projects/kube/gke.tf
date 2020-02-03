module "gke" {
  source   = "../../modules/gke/container-cluster"
  project  = "${data.terraform_remote_state.projects.kube.project_id}"
  name     = "${var.gke_name}"
  location = "${var.region}"

  min_master_version = "${var.gke_min_master_version}"
  node_version       = "${var.gke_node_version}"

  # Using self_link for network and subnetwork seems to force GKE cluster
  # to be recreated at each terraform apply.
  # Using name seems to fix this...
  network = "${module.network.name}"

  subnetwork = "${module.subnetwork.name}"
}

module "gke-pool-1" {
  source       = "../../modules/gke/node-pool"
  project      = "${data.terraform_remote_state.projects.kube.project_id}"
  name_prefix  = "np"
  location     = "${var.region}"
  cluster      = "${module.gke.name}"
  node_count   = "${var.gke_node_count}"
  machine_type = "${var.gke_machine_type}"
  disk_size_gb = "${var.gke_disk_size_gb}"

  oauth_scopes = [
    "compute-rw",
    "storage-rw",
    "logging-write",
    "monitoring",
  ]

  preemptible  = "${var.gke_preemptible}"
  auto_repair  = "${var.gke_auto_repair}"
  auto_upgrade = "${var.gke_auto_upgrade}"
}
