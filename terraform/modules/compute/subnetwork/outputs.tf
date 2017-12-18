output "name" {
  value = "${google_compute_subnetwork.default.name}"
}

output "gateway_address" {
  value = "${google_compute_subnetwork.default.gateway_address}"
}

output "self_link" {
  value = "${google_compute_subnetwork.default.self_link}"
}

output "ip_cidr_range" {
  value = "${google_compute_subnetwork.default.ip_cidr_range}"
}
