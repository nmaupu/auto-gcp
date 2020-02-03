resource "google_container_node_pool" "default" {
  project     = "${var.project}"
  name_prefix = "${var.name_prefix}-"
  location    = "${var.location}"
  cluster     = "${var.cluster}"
  node_count  = "${var.node_count}"

  node_config {
    machine_type = "${var.machine_type}"
    disk_size_gb = "${var.disk_size_gb}"
    oauth_scopes = "${var.oauth_scopes}"
    preemptible  = "${var.preemptible}"
  }

  management {
    auto_repair  = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }
}
