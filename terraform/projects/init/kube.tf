##
# Creating project
##
module "kube" {
  source          = "../../modules/project"
  project_name    = "${var.kube_project_name}"
  org_id          = "${var.org_id}"
  billing_account = "${var.billing_account}"
}

module "kube_service" {
  source     = "../../modules/project_service"
  project_id = "${module.kube.project_id}"
  service    = "compute.googleapis.com"
}

module "dns_service" {
  source     = "../../modules/project_service"
  project_id = "${module.kube.project_id}"
  service    = "dns.googleapis.com"
}

module "monitoring_service" {
  source     = "../../modules/project_service"
  project_id = "${module.kube.project_id}"
  service    = "monitoring.googleapis.com"
}

module "container_service" {
  source     = "../../modules/project_service"
  project_id = "${module.kube.project_id}"
  service    = "container.googleapis.com"
}

module "kube_sshkeys" {
  source      = "../../modules/sshkeys"
  credentials = "${var.credentials}"
  project     = "${module.kube.project_id}"
}

module "kube_pub1_managed_zone" {
  source     = "../../modules/dns/managed_zone"
  name       = "${var.kube_pub1_zone_name}"
  dns_name   = "${var.kube_pub1_dns_name}"
  project_id = "${module.kube.project_id}"
}

module "kube_priv1_managed_zone" {
  source     = "../../modules/dns/managed_zone"
  name       = "${var.kube_priv1_zone_name}"
  dns_name   = "${var.kube_priv1_dns_name}"
  project_id = "${module.kube.project_id}"
}

module "kube_pro1_managed_zone" {
  source     = "../../modules/dns/managed_zone"
  name       = "${var.kube_pro1_zone_name}"
  dns_name   = "${var.kube_pro1_dns_name}"
  project_id = "${module.kube.project_id}"
}
