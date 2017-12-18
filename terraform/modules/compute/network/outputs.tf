output "name" {
  value = "${google_compute_network.default.name}"
}

output "gateway_ipv4" {
  value = "${google_compute_network.default.gateway_ipv4}"
}

output "self_link" {
  value = "${google_compute_network.default.self_link}"
}
