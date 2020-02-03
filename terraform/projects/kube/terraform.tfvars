region = "europe-west1"

backup_bucket_name = "nma-backup"
backup_bucket_storage_class = "REGIONAL"
lifecycle_condition_age = "60"

network_name = "kube-network"
subnetwork_name = "kube-subnetwork"
cidr = "10.42.42.0/24"

gke_name = "nma-kube"
gke_min_master_version = "1.15.8-gke.2"
gke_node_version = "1.15.8-gke.2"

# Number of nodes by zone
gke_node_count = "2"
gke_machine_type = "n1-standard-1"
gke_disk_size_gb = "10"
gke_preemptible = "true"
gke_auto_repair = "true"
gke_auto_upgrade = "true"

# public rproxy
rproxy_pub_name = "rproxy-pub"
rproxy_pub_machine_type = "f1-micro"
rproxy_pub_preemptible = "false"
rproxy_image_pub = "rproxy-pub-2020-02-03t00-34-48z"

# private rproxy
rproxy_priv_name = "rproxy-priv"
rproxy_priv_machine_type = "f1-micro"
rproxy_priv_preemptible = "false"
rproxy_image_priv = "rproxy-priv-2020-02-03t00-35-51z"

rproxy_http_port = "80"
rproxy_https_port = "443"
rproxy_ssh_port = "22"
ingwatcher_ports = [
  "6565",
  "6566"
]
