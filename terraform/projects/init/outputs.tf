output "kube.project_id" {
  value = "${module.kube.project_id}"
}

output "kube.pub1_managed_zone" {
  value = "${module.kube_pub1_managed_zone.name}"
}

output "kube.priv1_managed_zone" {
  value = "${module.kube_priv1_managed_zone.name}"
}

output "kube.pro1_managed_zone" {
  value = "${module.kube_pro1_managed_zone.name}"
}

output "kube.pub1_dns_name" {
  value = "${module.kube_pub1_managed_zone.dns_name}"
}

output "kube.priv1_dns_name" {
  value = "${module.kube_priv1_managed_zone.dns_name}"
}

output "kube.pro1_dns_name" {
  value = "${module.kube_pro1_managed_zone.dns_name}"
}

output "kube.pub1_name_servers" {
  value = "${module.kube_pub1_managed_zone.name_servers}"
}

output "kube.priv1_name_servers" {
  value = "${module.kube_priv1_managed_zone.name_servers}"
}

output "kube.pro1_name_servers" {
  value = "${module.kube_pro1_managed_zone.name_servers}"
}
