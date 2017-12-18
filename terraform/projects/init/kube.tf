##
# Creating project
##
# TODO - when quota is ok again, make it generic
#module "kube" {
#  source = "../../modules/project"
#  project_name = "${var.kube_project_name}"
#  org_id = "${var.org_id}"
#  billing_account = "${var.billing_account}"
#}
resource "google_project" "kube" {
  name            = "kube"
  project_id      = "kube-802de212"
  billing_account = "${var.billing_account}"
  org_id          = "${var.org_id}"
}

module "kube_service" {
  source     = "../../modules/project_service"
  project_id = "${google_project.kube.project_id}"
  service    = "compute.googleapis.com"
}

module "kube_sshkeys" {
  source      = "../../modules/sshkeys"
  credentials = "${var.credentials}"
  project     = "${google_project.kube.project_id}"
}

module "kube_managed_zone" {
  source     = "../../modules/dns/managed_zone"
  name       = "${var.kube_zone_name}"
  dns_name   = "${var.kube_dns_name}"
  project_id = "${google_project.kube.project_id}"
}

module "kube_priv_managed_zone" {
  source     = "../../modules/dns/managed_zone"
  name       = "${var.kube_priv_zone_name}"
  dns_name   = "${var.kube_priv_dns_name}"
  project_id = "${google_project.kube.project_id}"
}

#
## Outputs
#
output "kube.project_id" {
  value = "${google_project.kube.project_id}"
}

output "kube.managed_zone" {
  value = "${module.kube_managed_zone.name}"
}

output "kube.priv_managed_zone" {
  value = "${module.kube_priv_managed_zone.name}"
}

output "kube.dns_name" {
  value = "${module.kube_managed_zone.dns_name}"
}

output "kube.priv_dns_name" {
  value = "${module.kube_priv_managed_zone.dns_name}"
}

output "kube.name_servers" {
  value = "${module.kube_managed_zone.name_servers}"
}

output "kube.priv_name_servers" {
  value = "${module.kube_priv_managed_zone.name_servers}"
}
