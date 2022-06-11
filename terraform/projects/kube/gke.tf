module "gke" {
  source          = "../../modules/gke/container-cluster"
  project         = data.terraform_remote_state.projects.outputs.kube_project_id
  name            = var.gke_name
  master_location = "${var.region}-c"

  min_master_version = var.gke_min_master_version

  # Using self_link for network and subnetwork seems to force GKE cluster
  # to be recreated at each terraform apply.
  # Using name seems to fix this...
  network    = module.network.name
  subnetwork = module.subnetwork.name

  persistent_disk_csi_enabled = var.gke_persistent_disk_csi_enabled
}

module "gke-pool-1" {
  source        = "../../modules/gke/node-pool"
  project       = data.terraform_remote_state.projects.outputs.kube_project_id
  name_prefix   = "np"
  location      = "${var.region}-c" # Zone in which the cluster is installed
  cluster       = module.gke.name
  node_count    = var.gke_node_count
  machine_type  = var.gke_machine_type
  disk_size_gb  = var.gke_disk_size_gb
  nodes_version = var.gke_node_version
  tags          = ["${var.gke_name}-nodes"]

  oauth_scopes = [
    "compute-rw",
    "storage-rw",
    "logging-write",
    "monitoring",
  ]

  preemptible  = var.gke_preemptible
  auto_repair  = var.gke_auto_repair
  auto_upgrade = var.gke_auto_upgrade
}

