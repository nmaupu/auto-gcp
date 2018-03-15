resource "google_container_cluster" "default" {
  name               = "${var.name}"
  zone               = "${var.zone}"
  additional_zones   = ["${var.additional_zones}"]
  min_master_version = "${var.min_master_version}"
  node_version       = "${var.node_version}"

  # Force RBAC
  enable_legacy_abac = false

  master_auth {
    username = "${var.username}"
    password = "${var.password}"
  }

  network    = "${var.network}"
  subnetwork = "${var.subnetwork}"
  project    = "${var.project}"

  node_pool = {
    name       = "default-pool"
    node_count = "${var.node_count}"

    management {
      auto_repair  = "${var.auto_repair}"
      auto_upgrade = "${var.auto_upgrade}"
    }

    node_config {
      oauth_scopes = "${var.oauth_scopes}"

      machine_type = "${var.machine_type}"
      disk_size_gb = "${var.disk_size_gb}"

      preemptible = "${var.preemptible}"
    }
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = true
    }

    kubernetes_dashboard {
      disabled = true
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }
}
