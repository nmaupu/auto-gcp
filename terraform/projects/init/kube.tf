##
# Creating project
##
module "kube" {
  source = "../../modules/project"
  project_name = "${var.kube_project_name}"
  org_id = "${var.org_id}"
  billing_account = "${var.billing_account}"
}

module "kube_service" {
  source     = "../../modules/project_service"
  project_id = "${module.kube.project_id}"
  service    = "compute.googleapis.com"
}

module "dns_service" {
  source      = "../../modules/project_service"
  project_id = "${module.kube.project_id}"
  service   = "dns.googleapis.com"
}

module "container_service" {
  source      = "../../modules/project_service"
  project_id = "${module.kube.project_id}"
  service   = "container.googleapis.com"
}

module "kube_sshkeys" {
  source      = "../../modules/sshkeys"
  credentials = "${var.credentials}"
  project     = "${module.kube.project_id}"
}

module "kube_managed_zone" {
  source     = "../../modules/dns/managed_zone"
  name       = "${var.kube_zone_name}"
  dns_name   = "${var.kube_dns_name}"
  project_id = "${module.kube.project_id}"
}

module "kube_priv_managed_zone" {
  source     = "../../modules/dns/managed_zone"
  name       = "${var.kube_priv_zone_name}"
  dns_name   = "${var.kube_priv_dns_name}"
  project_id = "${module.kube.project_id}"
}

module "kube_pro_1_managed_zone" {
  source     = "../../modules/dns/managed_zone"
  name       = "${var.kube_pro_1_zone_name}"
  dns_name   = "${var.kube_pro_1_dns_name}"
  project_id = "${module.kube.project_id}"
}

#
## Outputs
#
output "kube.project_id" {
  value = "${module.kube.project_id}"
}

output "kube.managed_zone" {
  value = "${module.kube_managed_zone.name}"
}

output "kube.priv_managed_zone" {
  value = "${module.kube_priv_managed_zone.name}"
}

output "kube.pro_1_managed_zone" {
  value = "${module.kube_pro_1_managed_zone.name}"
}

output "kube.dns_name" {
  value = "${module.kube_managed_zone.dns_name}"
}

output "kube.priv_dns_name" {
  value = "${module.kube_priv_managed_zone.dns_name}"
}

output "kube.pro_1_dns_name" {
  value = "${module.kube_pro_1_managed_zone.dns_name}"
}

output "kube.name_servers" {
  value = "${module.kube_managed_zone.name_servers}"
}

output "kube.priv_name_servers" {
  value = "${module.kube_priv_managed_zone.name_servers}"
}

output "kube.pro_1_name_servers" {
  value = "${module.kube_pro_1_managed_zone.name_servers}"
}
