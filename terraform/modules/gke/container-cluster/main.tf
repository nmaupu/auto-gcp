resource "google_container_cluster" "default" {
  provider           = google-beta
  name               = var.name
  location           = var.master_location
  node_locations     = var.nodes_location
  min_master_version = var.min_master_version

  # Force RBAC
  enable_legacy_abac = false

  network    = var.network
  subnetwork = var.subnetwork
  project    = var.project

  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }

  cluster_autoscaling {
    enabled = false
  }

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = true
    }

    # beta - not working : 400 bad request: requires recreation of node pools
    gce_persistent_disk_csi_driver_config {
      enabled = var.persistent_disk_csi_enabled
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  lifecycle {
    ignore_changes = [
      initial_node_count,
    ]
  }
}
