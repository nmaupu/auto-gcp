module "rproxy-dns-record" {
  source       = "../../modules/dns/record_set"
  name         = "*.${data.terraform_remote_state.projects.kube.dns_name}"
  type         = "A"
  ttl          = "3600"
  managed_zone = "${data.terraform_remote_state.projects.kube.managed_zone}"

  rrdatas = [
    "${module.rproxy-pub-instance.nat_ip}",
  ]

  project_id = "${data.terraform_remote_state.projects.kube.project_id}"
}

module "rproxy-priv-dns-record" {
  source       = "../../modules/dns/record_set"
  name         = "*.${data.terraform_remote_state.projects.kube.priv_dns_name}"
  type         = "A"
  ttl          = "3600"
  managed_zone = "${data.terraform_remote_state.projects.kube.priv_managed_zone}"

  rrdatas = [
    "${module.rproxy-priv-instance.nat_ip}",
  ]

  project_id = "${data.terraform_remote_state.projects.kube.project_id}"
}
