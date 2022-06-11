output "gke_client_certificate" {
  value     = module.gke.client_certificate
  sensitive = true
}

output "gke_client_key" {
  value     = module.gke.client_key
  sensitive = true
}

output "gke_cluster_ca_certificate" {
  value = module.gke.cluster_ca_certificate
}

output "gke_master_version" {
  value = module.gke.master_version
}

output "gke_self_link" {
  value = module.gke.self_link
}

output "gke_id" {
  value = module.gke.id
}
