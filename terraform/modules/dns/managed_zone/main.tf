resource "google_dns_managed_zone" "default" {
  name        = "${var.name}"
  dns_name    = "${var.dns_name}"
  description = "${var.dns_name} zone is managed by terraform"
  project     = "${var.project_id}"
}
