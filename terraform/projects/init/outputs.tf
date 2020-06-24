output "kube_project_id" {
  value = module.kube.project_id
}

output "kube_pub1_managed_zone" {
  value = module.kube_pub1_managed_zone.name
}

output "kube_priv1_managed_zone" {
  value = module.kube_priv1_managed_zone.name
}

output "kube_pro1_managed_zone" {
  value = module.kube_pro1_managed_zone.name
}

output "kube_pub1_dns_name" {
  value = module.kube_pub1_managed_zone.dns_name
}

output "kube_priv1_dns_name" {
  value = module.kube_priv1_managed_zone.dns_name
}

output "kube_pro1_dns_name" {
  value = module.kube_pro1_managed_zone.dns_name
}

output "kube_pub1_name_servers" {
  value = module.kube_pub1_managed_zone.name_servers
}

output "kube_priv1_name_servers" {
  value = module.kube_priv1_managed_zone.name_servers
}

output "kube_pro1_name_servers" {
  value = module.kube_pro1_managed_zone.name_servers
}

