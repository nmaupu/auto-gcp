##
# DNS entries for pro_1 (s*****.fr)
##

module "pro_1_MX_records" {
  source       = "../../modules/dns/record_set"
  project_id   = "${module.kube.project_id}"
  managed_zone = "${module.kube_pro_1_managed_zone.name}"
  name         = "${module.kube_pro_1_managed_zone.dns_name}"

  type         = "MX"
  ttl          = "3600"
  rrdatas = [
    "1 ASPMX.L.GOOGLE.COM.",
    "10 ASPMX2.GOOGLEMAIL.COM.",
    "10 ASPMX3.GOOGLEMAIL.COM.",
    "5 ALT1.ASPMX.L.GOOGLE.COM.",
    "5 ALT2.ASPMX.L.GOOGLE.COM.",
  ]
}

module "pro_1_TXT_mail_record" {
  source       = "../../modules/dns/record_set"
  project_id   = "${module.kube.project_id}"
  managed_zone = "${module.kube_pro_1_managed_zone.name}"
  name         = "${module.kube_pro_1_managed_zone.dns_name}"

  type         = "TXT"
  ttl          = "10800"
  rrdatas = [
    "\"google-site-verification=AeslZhCyOJu2FLxdQn_b7kApIMXaF1R1KjGr2LiIp2A\"",
  ]
}
