module "rproxy-pub1-dns-record-A" {
  source       = "../../modules/dns/record_set"
  name         = "*.${data.terraform_remote_state.projects.kube.pub1_dns_name}"
  type         = "A"
  ttl          = "86400"
  managed_zone = "${data.terraform_remote_state.projects.kube.pub1_managed_zone}"

  rrdatas = [
    "${module.rproxy-pub-instance.nat_ip}",
  ]

  project_id = "${data.terraform_remote_state.projects.kube.project_id}"
}

module "rproxy-priv1-dns-record-A" {
  source       = "../../modules/dns/record_set"
  name         = "*.${data.terraform_remote_state.projects.kube.priv1_dns_name}"
  type         = "A"
  ttl          = "86400"
  managed_zone = "${data.terraform_remote_state.projects.kube.priv1_managed_zone}"

  rrdatas = [
    "${module.rproxy-priv-instance.nat_ip}",
  ]

  project_id = "${data.terraform_remote_state.projects.kube.project_id}"
}

module "rproxy-pro1-dns-record-A" {
  source       = "../../modules/dns/record_set"
  name         = "*.${data.terraform_remote_state.projects.kube.pro1_dns_name}"
  type         = "A"
  ttl          = "86400"
  managed_zone = "${data.terraform_remote_state.projects.kube.pro1_managed_zone}"

  rrdatas = [
    "${module.rproxy-priv-instance.nat_ip}",
  ]

  project_id = "${data.terraform_remote_state.projects.kube.project_id}"
}

# Access to rproxy-priv and rproxy-pub using DNS
module "rproxy-pub1-dns-record-A-internal" {
  source       = "../../modules/dns/record_set"
  name         = "rproxy-pub.${data.terraform_remote_state.projects.kube.priv1_dns_name}"
  type         = "A"
  ttl          = "3600"
  managed_zone = "${data.terraform_remote_state.projects.kube.priv1_managed_zone}"

  rrdatas = [
    "${module.rproxy-pub-instance.internal_ip}",
  ]

  project_id = "${data.terraform_remote_state.projects.kube.project_id}"
}

module "rproxy-priv1-dns-record-A-internal" {
  source       = "../../modules/dns/record_set"
  name         = "rproxy-priv.${data.terraform_remote_state.projects.kube.priv1_dns_name}"
  type         = "A"
  ttl          = "3600"
  managed_zone = "${data.terraform_remote_state.projects.kube.priv1_managed_zone}"

  rrdatas = [
    "${module.rproxy-priv-instance.internal_ip}",
  ]

  project_id = "${data.terraform_remote_state.projects.kube.project_id}"
}
