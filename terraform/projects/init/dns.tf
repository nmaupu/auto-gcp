##
# DNS entries for pro1 (s*****.fr)
##

module "pro1_MX_records" {
  source       = "../../modules/dns/record_set"
  project_id   = module.kube.project_id
  managed_zone = module.kube_pro1_managed_zone.name
  name         = module.kube_pro1_managed_zone.dns_name

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
  project_id   = module.kube.project_id
  managed_zone = module.kube_pro1_managed_zone.name
  name         = module.kube_pro1_managed_zone.dns_name

  type = "TXT"
  ttl  = "10800"

  rrdatas = [
    "\"google-site-verification=AeslZhCyOJu2FLxdQn_b7kApIMXaF1R1KjGr2LiIp2A\"",
  ]
}

##
# DNS entries for pub (b*****.fr)
##

module "pub1_MX_records" {
  source       = "../../modules/dns/record_set"
  project_id   = module.kube.project_id
  managed_zone = module.kube_pub1_managed_zone.name
  name         = module.kube_pub1_managed_zone.dns_name

  type = "MX"
  ttl  = "86400"

  rrdatas = [
    "10 aspmx.l.google.com.",
    "30 aspmx2.googlemail.com.",
    "30 aspmx3.googlemail.com.",
    "30 aspmx4.googlemail.com.",
    "30 aspmx5.googlemail.com.",
  ]
}

module "pub1_CNAME_verify_mail_1" {
  source       = "../../modules/dns/record_set"
  project_id   = module.kube.project_id
  managed_zone = module.kube_pub1_managed_zone.name
  name         = "DDSJUQX4KUYZ.${module.kube_pub1_managed_zone.dns_name}"

  type = "CNAME"
  ttl  = "86400"

  rrdatas = [
    "gv-dbhxxbgvyphmchlmxe2b7b7y5ptllflaxtf4adouarplzg2wkypq.domainverify.googlehosted.com."
  ]
}

module "pub1_CNAME_verify_mail_2" {
  source       = "../../modules/dns/record_set"
  project_id   = module.kube.project_id
  managed_zone = module.kube_pub1_managed_zone.name
  name         = "googleffffffffe979ab69.${module.kube_pub1_managed_zone.dns_name}"

  type = "CNAME"
  ttl  = "86400"

  rrdatas = [
    "google.com."
  ]
}

module "pub1_CNAME_voyages" {
  source       = "../../modules/dns/record_set"
  project_id   = module.kube.project_id
  managed_zone = module.kube_pub1_managed_zone.name
  name         = "voyages.${module.kube_pub1_managed_zone.dns_name}"

  type = "CNAME"
  ttl  = "864000"

  rrdatas = [
    "ghs.google.com."
  ]
}

module "pub1_TXT_mail_dkim" {
  source       = "../../modules/dns/record_set"
  project_id   = module.kube.project_id
  managed_zone = module.kube_pub1_managed_zone.name
  name         = "google._domainkey.${module.kube_pub1_managed_zone.dns_name}"

  type = "TXT"
  ttl  = "10800"

  rrdatas = [
    "\"v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqp2pAILwzERA6uUucbYWgnIsUOqyGu0TOBYGmbOPrfs3KL5yLFM6I4fTJ6SNAS5jwIE7BAi3YqzOMvxrNYSwQnzrO8DHNNH8JAwO6q9cpWj6lO4nF2iXSi8TwFXvdJnWapdqEBL+qB7AlXzGD0aJoXIJieoE/+LBKp0TMFNAFo5iDUOXyQ22FhG6RrSH3PEFP\" \"Vlz0bKPO/rJ2VVs8Ks//toKCas8whiNRpDw/cbJhSiOskBI3h75NUlBsMs4oGgxlUKXqZH6Mg7dhS0iwpGb17FRw/nh+c7AfNynOv4AtI2nVrxMKUQWxvF6Ypr5Z8H+KWOpdAL9xQTgL3FnH1RxUwIDAQAB\"",
  ]
}

#module "pub1_CNAME_bing" {
#  source       = "../../modules/dns/record_set"
#  project_id   = module.kube.project_id
#  managed_zone = module.kube_pub1_managed_zone.name
#  name         = "${data.vault_kv_secret.bing.name}.${module.kube_pub1_managed_zone.dns_name}"
#
#  type = "CNAME"
#  ttl  = "10800"
#
#  rrdatas = [
#    data.vault_kv_secret.bing.value
#  ]
#}
#
#module "pub1_CNAME_bitly" {
#  source       = "../../modules/dns/record_set"
#  project_id   = module.kube.project_id
#  managed_zone = module.kube_pub1_managed_zone.name
#  name         = "${data.vault_kv_secret.bitly.name}.${module.kube_pub1_managed_zone.dns_name}"
#
#  type = "CNAME"
#  ttl  = "10800"
#
#  rrdatas = [
#    data.vault_kv_secret.bitly.value
#  ]
#}

##
# DNS entries for priv
##
module "home_root_records" {
  source       = "../../modules/dns/record_set"
  project_id   = module.kube.project_id
  managed_zone = module.kube_priv1_managed_zone.name
  name         = "home.${module.kube_priv1_managed_zone.dns_name}"

  type = "A"
  ttl  = "86400"

  rrdatas = [
    var.home_ip,
  ]
}

module "home_web_records" {
  source       = "../../modules/dns/record_set"
  project_id   = module.kube.project_id
  managed_zone = module.kube_priv1_managed_zone.name
  name         = "web-static.home.${module.kube_priv1_managed_zone.dns_name}"

  type = "CNAME"
  ttl  = "86400"

  rrdatas = [
    "home.${module.kube_priv1_managed_zone.dns_name}",
  ]
}

module "priv1_TXT_mail_dkim" {
  source       = "../../modules/dns/record_set"
  project_id   = module.kube.project_id
  managed_zone = module.kube_priv1_managed_zone.name
  name         = "google._domainkey.${module.kube_priv1_managed_zone.dns_name}"

  type = "TXT"
  ttl  = "10800"

  rrdatas = [
    "\"v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuUo/JahfI1oJNbql8G1Et9yGWlD7H16zOMWNljBfGdLvGI/x7zUJfth8iEBT9rvI/3XZ3T7M263EWhrmru/qYYop4AHROIAh0fFc2J5xEBRGrLkalwetDt5MoxgAgMQaEdadu+Dt/LO6vixnpGxyjmDvIoNVKk4tns6N+4EJZ+PLeeg0QsL3hlQSdjH8vdKk2\" \"WjgRZdrDjKb+giC8GO83dDOcLfIOIM5J0SLRTi24rx82zu3rRX7CMPUxXNCVHGVGLhxSSBdwuXEWeKVF163jPSekrGGZJni9Xgp6RctRfrlo5IW6dCPXghNdkMFX9rLf9p9cstskRpWwE8mhjQjNQIDAQAB\"",
  ]
}

# module "nas_home_root_records" {
#   source       = "../../modules/dns/record_set"
#   project_id   = module.kube.project_id
#   managed_zone = module.kube_priv1_managed_zone.name
#   name         = "nas.home.${module.kube_priv1_managed_zone.dns_name}"
#
#   type = "CNAME"
#   ttl  = "86400"
#
#   rrdatas = [
#     "home.${module.kube_priv1_managed_zone.dns_name}",
#   ]
# }
#
# module "hass_home_root_records" {
#   source       = "../../modules/dns/record_set"
#   project_id   = module.kube.project_id
#   managed_zone = module.kube_priv1_managed_zone.name
#   name         = "hass.home.${module.kube_priv1_managed_zone.dns_name}"
#
#   type = "CNAME"
#   ttl  = "86400"
#
#   rrdatas = [
#     "home.${module.kube_priv1_managed_zone.dns_name}",
#   ]
# }
