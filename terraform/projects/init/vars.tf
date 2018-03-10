variable "region" {}
variable "org_id" {}
variable "billing_account" {}

variable "credentials" {
  type = "map"
}

# Kube project
variable "kube_project_name" {}
variable "kube_zone_name" {}
variable "kube_dns_name" {}

variable "kube_priv_zone_name" {}
variable "kube_priv_dns_name" {}

variable "kube_pro_1_zone_name" {}
variable "kube_pro_1_dns_name" {}
