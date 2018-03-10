region = "europe-west1"

network_name = "kube-network"
subnetwork_name = "kube-subnetwork"
cidr = "10.42.42.0/24"

gke_name = "nma-kube"
gke_min_master_version = "1.9.3-gke.0"
gke_node_version = "1.9.3-gke.0"
gke_initial_node_count = "2"
gke_preemptible = "true"
gke_disk_size_gb = "10"
gke_machine_type = "f1-micro"

# public rproxy
rproxy_pub_name = "rproxy-pub"
rproxy_pub_machine_type = "f1-micro"
rproxy_pub_preemptible = "false"
rproxy_image_pub = "rproxy-pub-2018-03-10t19-53-05z"

# public rproxy
rproxy_priv_name = "rproxy-priv"
rproxy_priv_machine_type = "f1-micro"
rproxy_priv_preemptible = "false"
rproxy_image_priv = "rproxy-priv-2018-03-10t19-48-46z"

rproxy_priv_sources = [
  "78.192.25.46/32"
]

rproxy_http_port = "80"
rproxy_https_port = "443"
rproxy_ssh_port = "22"
