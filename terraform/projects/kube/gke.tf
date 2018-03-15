module "gke" {
  source  = "../../modules/gke-cluster"
  project = "${data.terraform_remote_state.projects.kube.project_id}"
  name    = "${var.gke_name}"
  zone    = "${data.google_compute_zones.available.names[0]}"

  # GKE will be created using "node_count" instances by zone
  # in all zones provided in "additional_zones"
  # Example :
  #
  # initial_node_count=2
  # additional_zones=["europe-west1b", "europe-west1c"]
  # will create a clusters with 4 nodes (2 in each zone)
  #
  # For small instances and persistent storage support, it's better to have at least 2 machines in the same zone ;)
  additional_zones = ["${slice(data.google_compute_zones.available.names, 1, 2)}"]

  min_master_version = "${var.gke_min_master_version}"
  node_version       = "${var.gke_node_version}"

  username = "${var.gke_username}"
  password = "${var.gke_password}"

  # Node related
  node_count   = "${var.gke_node_count}"
  auto_repair  = true
  auto_upgrade = false

  oauth_scopes = [
    "compute-rw",
    "storage-ro",
    "logging-write",
    "monitoring",
  ]

  machine_type = "${var.gke_machine_type}"
  disk_size_gb = "${var.gke_disk_size_gb}"

  # Using self_link for network and subnetwork seem to force GKE cluster
  # to be recreated at each terraform apply.
  # Using name seems to fix this...
  network = "${module.network.name}"

  subnetwork = "${module.subnetwork.name}"
}
