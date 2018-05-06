##
# DNS entries for pro1 (s*****.fr)
##

module "pro1_MX_records" {
  source       = "../../modules/dns/record_set"
  project_id   = "${module.kube.project_id}"
  managed_zone = "${module.kube_pro1_managed_zone.name}"
  name         = "${module.kube_pro1_managed_zone.dns_name}"

  type = "MX"
  ttl  = "3600"

  rrdatas = [
    "1 aspmx.l.google.com.",
    "10 aspmx2.googlemail.com.",
    "10 aspmx3.googlemail.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
  ]
}

module "pro1_TXT_mail_record" {
  source       = "../../modules/dns/record_set"
  project_id   = "${module.kube.project_id}"
  managed_zone = "${module.kube_pro1_managed_zone.name}"
  name         = "${module.kube_pro1_managed_zone.dns_name}"

  type = "TXT"
  ttl  = "10800"

  rrdatas = [
    "\"google-site-verification=AeslZhCyOJu2FLxdQn_b7kApIMXaF1R1KjGr2LiIp2A\"",
  ]
}

##
# DNS entries for priv
#
module "home_root_records" {
  source       = "../../modules/dns/record_set"
  project_id   = "${module.kube.project_id}"
  managed_zone = "${module.kube_priv1_managed_zone.name}"
  name         = "home.${module.kube_priv1_managed_zone.dns_name}"

  type = "A"
  ttl  = "86400"

  rrdatas = [
    "${var.home_ip}"
  ]
}

module "nas_home_root_records" {
  source       = "../../modules/dns/record_set"
  project_id   = "${module.kube.project_id}"
  managed_zone = "${module.kube_priv1_managed_zone.name}"
  name         = "nas.home.${module.kube_priv1_managed_zone.dns_name}"

  type = "CNAME"
  ttl  = "86400"

  rrdatas = [
    "home.${module.kube_priv1_managed_zone.dns_name}"
  ]
}
