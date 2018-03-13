module "gke" {
  source             = "../../modules/gke-cluster"
  name               = "${var.gke_name}"
  zone               = "${data.google_compute_zones.available.names[0]}"
  # GKE will be created using "initial_node_count" instances by zone
  # in all zones provided in "additional_zones"
  # Examples :
  #
  # initial_node_count=2
  # additional_zones=["europe-west1b", "europe-west1c"]
  # will create a clusters with 4 nodes (2 in each zone)
  #
  # initial_node_count=1
  # additional_zones=["europe-west1b", "europe-west1c", "europe-west1d"]
  # will create a clusters with 3 nodes (1 in each zone)
  #
  # initial_node_count=3
  # additional_zones=["europe-west1b"]
  # will create a clusters with 3 nodes (with only one zone)
  #
  # For small instances and persistent storage support, it's better to have at least 2 machines in the same zone ;)
  # use length(data.google_compute_zones.available.names) with or without "-1" to force the number of additional_zones to use
  additional_zones   = ["${slice(data.google_compute_zones.available.names, 1, length(data.google_compute_zones.available.names) - 1)}"]
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
