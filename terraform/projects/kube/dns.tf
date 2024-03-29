module "rproxy-pub1-dns-record-A" {
  source       = "../../modules/dns/record_set"
  name         = "*.${data.terraform_remote_state.projects.outputs.kube_pub1_dns_name}"
  type         = "A"
  ttl          = "86400"
  managed_zone = data.terraform_remote_state.projects.outputs.kube_pub1_managed_zone

  rrdatas = [
    module.rproxy-pub-instance.nat_ip,
  ]

  project_id = data.terraform_remote_state.projects.outputs.kube_project_id
}

module "rproxy-pub1-dns-record-A-base" {
  source       = "../../modules/dns/record_set"
  name         = "${data.terraform_remote_state.projects.outputs.kube_pub1_dns_name}"
  type         = "A"
  ttl          = "86400"
  managed_zone = data.terraform_remote_state.projects.outputs.kube_pub1_managed_zone

  rrdatas = [
    module.rproxy-pub-instance.nat_ip,
  ]

  project_id = data.terraform_remote_state.projects.outputs.kube_project_id
}

module "rproxy-pub1-dns-record-CNAME-www" {
  source       = "../../modules/dns/record_set"
  name         = "www.${data.terraform_remote_state.projects.outputs.kube_pub1_dns_name}"
  type         = "CNAME"
  ttl          = "86400"
  managed_zone = data.terraform_remote_state.projects.outputs.kube_pub1_managed_zone

  rrdatas = [
    data.terraform_remote_state.projects.outputs.kube_pub1_dns_name
  ]

  project_id = data.terraform_remote_state.projects.outputs.kube_project_id
}

module "pub1_TXT_SPF" {
  source       = "../../modules/dns/record_set"
  name = "blog-spf.${data.terraform_remote_state.projects.outputs.kube_pub1_dns_name}"
  type = "TXT"
  ttl  = "86400"
  managed_zone = data.terraform_remote_state.projects.outputs.kube_pub1_managed_zone

  rrdatas = [
    "v=spf1 ip4:${module.rproxy-pub-instance.nat_ip}/32 ip4:${module.subnetwork.ip_cidr_range} ip4:${module.gke.cluster_ipv4_cidr} include:_spf.google.com ~all"
  ]

  project_id = data.terraform_remote_state.projects.outputs.kube_project_id
}

module "rproxy-priv1-dns-record-A" {
  source       = "../../modules/dns/record_set"
  name         = "*.${data.terraform_remote_state.projects.outputs.kube_priv1_dns_name}"
  type         = "A"
  ttl          = "86400"
  managed_zone = data.terraform_remote_state.projects.outputs.kube_priv1_managed_zone

  rrdatas = [
    module.rproxy-priv-instance.nat_ip,
  ]

  project_id = data.terraform_remote_state.projects.outputs.kube_project_id
}

module "rproxy-pro1-dns-record-A" {
  source       = "../../modules/dns/record_set"
  name         = "*.priv.${data.terraform_remote_state.projects.outputs.kube_pro1_dns_name}"
  type         = "A"
  ttl          = "86400"
  managed_zone = data.terraform_remote_state.projects.outputs.kube_pro1_managed_zone

  rrdatas = [
    module.rproxy-priv-instance.nat_ip,
  ]

  project_id = data.terraform_remote_state.projects.outputs.kube_project_id
}

module "rproxy-pro1-dns-record-A-pub" {
  source       = "../../modules/dns/record_set"
  name         = "*.pub.${data.terraform_remote_state.projects.outputs.kube_pro1_dns_name}"
  type         = "A"
  ttl          = "86400"
  managed_zone = data.terraform_remote_state.projects.outputs.kube_pro1_managed_zone

  rrdatas = [
    module.rproxy-pub-instance.nat_ip,
  ]

  project_id = data.terraform_remote_state.projects.outputs.kube_project_id
}

# Access to rproxy-priv and rproxy-pub using DNS
module "rproxy-pub1-dns-record-A-internal" {
  source       = "../../modules/dns/record_set"
  name         = "rproxy-pub.${data.terraform_remote_state.projects.outputs.kube_priv1_dns_name}"
  type         = "A"
  ttl          = "3600"
  managed_zone = data.terraform_remote_state.projects.outputs.kube_priv1_managed_zone

  rrdatas = [
    module.rproxy-pub-instance.internal_ip,
  ]

  project_id = data.terraform_remote_state.projects.outputs.kube_project_id
}

module "rproxy-priv1-dns-record-A-internal" {
  source       = "../../modules/dns/record_set"
  name         = "rproxy-priv.${data.terraform_remote_state.projects.outputs.kube_priv1_dns_name}"
  type         = "A"
  ttl          = "3600"
  managed_zone = data.terraform_remote_state.projects.outputs.kube_priv1_managed_zone

  rrdatas = [
    module.rproxy-priv-instance.internal_ip,
  ]

  project_id = data.terraform_remote_state.projects.outputs.kube_project_id
}

