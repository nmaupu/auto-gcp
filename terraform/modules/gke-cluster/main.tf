resource "google_container_cluster" "default" {
  name               = "${var.name}"
  zone               = "${var.zone}"
  initial_node_count = "${var.initial_node_count}"
  additional_zones   = ["${var.additional_zones}"]
  min_master_version = "${var.min_master_version}"
  node_version       = "${var.node_version}"

  master_auth {
    username = "${var.username}"
    password = "${var.password}"
  }

  network    = "${var.network}"
  subnetwork = "${var.subnetwork}"
  project = "${var.project}"

  node_config {
    oauth_scopes = ["${var.oauth_scopes}"]
    disk_size_gb = "${var.disk_size_gb}"
    machine_type = "${var.machine_type}"
    preemptible  = "${var.preemptible}"

    labels {
      type               = "kube-node"
      cluster_name       = "${var.name}"
      min_master_version = "${var.min_master_version}"
      project            = "${var.project}"
    }

    tags = ["kube-node", "${var.name}"]
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
