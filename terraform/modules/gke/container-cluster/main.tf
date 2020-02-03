resource "google_container_cluster" "default" {
  name               = "${var.name}"
  location           = "${var.location}"
  node_locations     = ["${var.location}-b", "${var.location}-c"]
  min_master_version = "${var.min_master_version}"
  node_version       = "${var.node_version}"

  # Force RBAC
  enable_legacy_abac = false

  network    = "${var.network}"
  subnetwork = "${var.subnetwork}"
  project    = "${var.project}"

  lifecycle {
    ignore_changes = ["node_pool", "node_version"]
  }

  node_pool = {
    name       = "void-pool"
    node_count = "0"
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = true
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }
}
