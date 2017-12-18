region = "europe-west1"

network_name = "kube-network"
subnetwork_name = "kube-subnetwork"
cidr = "10.42.42.0/24"

gke_name = "nma-kube"
gke_min_master_version = "1.8.4-gke.0"
gke_initial_node_count = "2"
gke_preemptible = "true"
gke_disk_size_gb = "10"
gke_machine_type = "f1-micro"

# public rproxy
rproxy_pub_name = "rproxy-pub"
rproxy_pub_machine_type = "f1-micro"
rproxy_pub_preemptible = "false"
rproxy_image_pub = "rproxy-pub-2017-12-17t17-19-35z"

# public rproxy
rproxy_priv_name = "rproxy-priv"
rproxy_priv_machine_type = "f1-micro"
rproxy_priv_preemptible = "true"
rproxy_image_priv = "rproxy-priv-2017-12-17t17-27-07z"
rproxy_priv_sources = [
  "78.192.25.46"
]
rproxy_allow_ports = [
  "80", "443"
]
