# HTTP ok from default (packer)
resource "google_compute_firewall" "http-default" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  project = data.terraform_remote_state.projects.outputs.kube_project_id
}

# Allow ssh to nodes from private IPs
resource "google_compute_firewall" "ssh-k8s-nodes" {
  name = "k8s-nodes-ssh-allow"
  network = module.network.self_link

  source_ranges = var.rproxy_priv_sources
  target_tags = [
    "${var.gke_name}-nodes"
  ]

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  project     = data.terraform_remote_state.projects.outputs.kube_project_id
}

# ping ok from known sources
resource "google_compute_firewall" "rproxy-icmp-rules" {
  name    = "rproxy-icmp-allow"
  network = module.network.self_link

  allow {
    protocol = "icmp"
  }

  target_tags = ["rproxy-pub", "rproxy-priv"]
  project     = data.terraform_remote_state.projects.outputs.kube_project_id
}

# SSH ok from known sources
resource "google_compute_firewall" "rproxy-ssh-rules" {
  name    = "rproxy-ssh"
  network = module.network.self_link

  source_ranges = var.rproxy_priv_sources

  allow {
    protocol = "tcp"
    ports    = [var.rproxy_ssh_port]
  }

  target_tags = ["rproxy-pub", "rproxy-priv"]
  project     = data.terraform_remote_state.projects.outputs.kube_project_id
}

# http ok for all (let's encrypt validation)
resource "google_compute_firewall" "rproxy-http-rules" {
  name    = "rproxy-http"
  network = module.network.self_link

  allow {
    protocol = "tcp"

    ports = [
      var.rproxy_http_port,
    ]
  }

  target_tags = ["rproxy-pub", "rproxy-priv"]
  project     = data.terraform_remote_state.projects.outputs.kube_project_id
}

# https ok for pub only
resource "google_compute_firewall" "rproxy-pub-https-rules" {
  name    = "rproxy-pub-https"
  network = module.network.self_link

  allow {
    protocol = "tcp"

    ports = [
      var.rproxy_https_port,
    ]
  }

  target_tags = ["rproxy-pub"]
  project     = data.terraform_remote_state.projects.outputs.kube_project_id
}

# https from known sources for priv
resource "google_compute_firewall" "rproxy-priv-https-rules" {
  name    = "rproxy-priv-https"
  network = module.network.self_link

  source_ranges = var.rproxy_priv_sources

  allow {
    protocol = "tcp"

    ports = [
      var.rproxy_https_port,
    ]
  }

  target_tags = ["rproxy-priv"]
  project     = data.terraform_remote_state.projects.outputs.kube_project_id
}

# ingwatcher port from internal networks
resource "google_compute_firewall" "rproxy-kube-ingwatcher" {
  name    = "rproxy-kube-ingwatcher"
  network = module.network.self_link

  source_ranges = [
    module.subnetwork.ip_cidr_range,
    module.gke.cluster_ipv4_cidr,
  ]

  allow {
    protocol = "tcp"

    ports = var.ingwatcher_ports
  }

  target_tags = ["rproxy-priv", "rproxy-pub"]
  project     = data.terraform_remote_state.projects.outputs.kube_project_id
}

