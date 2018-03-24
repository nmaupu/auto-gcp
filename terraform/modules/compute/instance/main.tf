resource "google_compute_instance" "default" {
  name                      = "${var.name}"
  machine_type              = "${var.machine_type}"
  zone                      = "${var.zone}"
  project                   = "${var.project}"
  allow_stopping_for_update = "${var.allow_stopping_for_update}"

  tags = ["${var.tags}"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  attached_disk {
    source      = "${var.attached_disk_source}"
    device_name = "${var.attached_disk_device_name}"
  }

  network_interface {
    subnetwork    = "${var.subnetwork}"
    access_config = ["${var.access_config}"]
  }

  metadata {
    machine_type   = "${var.machine_type}"
    name           = "${var.name}"
    image          = "${var.image}"
    startup-script = "${var.startup_script}"
  }

  service_account {
    scopes = ["${var.service_account_scopes}"]
  }

  scheduling {
    preemptible       = "${var.preemptible}"
    automatic_restart = "${var.automatic_restart}"
    on_host_maintenance = "${var.on_host_maintenance}"
  }
}
