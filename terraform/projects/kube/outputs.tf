output "gke_username" {
  value = module.gke.username
}

output "gke_password" {
  value = module.gke.password
}

output "gke_client_certificate" {
  value = module.gke.client_certificate
}

output "gke_client_key" {
  value = module.gke.client_key
}

output "gke_cluster_ca_certificate" {
  value = module.gke.cluster_ca_certificate
}

output "gke_master_version" {
  value = module.gke.master_version
}
