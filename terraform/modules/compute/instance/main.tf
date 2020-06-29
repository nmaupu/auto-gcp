resource "google_compute_instance" "default" {
  name                      = var.name
  machine_type              = var.machine_type
  zone                      = var.zone
  project                   = var.project
  allow_stopping_for_update = var.allow_stopping_for_update

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  attached_disk {
    source      = var.attached_disk_source
    device_name = var.attached_disk_device_name
  }

  network_interface {
    subnetwork = var.subnetwork
    dynamic "access_config" {
      for_each = [var.access_config]
      content {
        # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
        # which keys might be set in maps assigned here, so it has
        # produced a comprehensive set here. Consider simplifying
        # this after confirming which keys can be set in practice.

        nat_ip                 = lookup(access_config.value, "nat_ip", null)
        network_tier           = lookup(access_config.value, "network_tier", null)
        public_ptr_domain_name = lookup(access_config.value, "public_ptr_domain_name", null)
      }
    }
  }

  metadata = {
    machine_type   = var.machine_type
    name           = var.name
    image          = var.image
    startup-script = var.startup_script
  }

  service_account {
    scopes = var.service_account_scopes
  }

  scheduling {
    preemptible         = var.preemptible
    automatic_restart   = var.preemptible ? "false" : var.automatic_restart
    on_host_maintenance = var.on_host_maintenance
  }
}

