# The following outputs allow authentication and connectivity to the GKE Cluster.
output "client_certificate" {
  value = google_container_cluster.default.master_auth[0].client_certificate
}

output "client_key" {
  value = google_container_cluster.default.master_auth[0].client_key
}

output "cluster_ca_certificate" {
  value = google_container_cluster.default.master_auth[0].cluster_ca_certificate
}

output "name" {
  value = google_container_cluster.default.name
}

output "master_version" {
  value = google_container_cluster.default.master_version
}

output "external_ip" {
  value = google_container_cluster.default.node_config
}

output "cluster_ipv4_cidr" {
  value = google_container_cluster.default.cluster_ipv4_cidr
}

