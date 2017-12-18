resource "google_compute_instance" "default" {
  name         = "${var.name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  project      = "${var.project}"

  tags = ["${var.tags}"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    subnetwork    = "${var.subnetwork}"
    access_config = {}
  }

  metadata {
    machine_type = "${var.machine_type}"
    name         = "${var.name}"
    image        = "${var.image}"
  }

  service_account {
    scopes = ["${var.service_account_scopes}"]
  }

  scheduling {
    preemptible = "${var.preemptible}"
    automatic_restart = "${var.automatic_restart}"
  }
}
