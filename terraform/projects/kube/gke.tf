module "gke" {
  source             = "../../modules/gke-cluster"
  name               = "${var.gke_name}"
  zone               = "${data.google_compute_zones.available.names[0]}"
  additional_zones   = ["${slice(data.google_compute_zones.available.names, 1, length(data.google_compute_zones.available.names))}"]
  min_master_version = "${var.gke_min_master_version}"
  node_version       = "${var.gke_node_version}"
  initial_node_count = "${var.gke_initial_node_count}"
  preemptible        = "${var.gke_preemptible}"
  username           = "${var.gke_username}"
  password           = "${var.gke_password}"

  # Using self_link for network and subnetwork seem to force GKE cluster
  # to be recreated at each terraform apply.
  # Using name seems to fix this...
  network = "${module.network.name}"

  subnetwork = "${module.subnetwork.name}"
  project    = "${data.terraform_remote_state.projects.kube.project_id}"

  oauth_scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_write",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
  ]

  disk_size_gb = "${var.gke_disk_size_gb}"
  machine_type = "${var.gke_machine_type}"
}
