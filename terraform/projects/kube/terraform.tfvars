region = "europe-west1"

backup_bucket_name = "nma-backup"
backup_bucket_storage_class = "REGIONAL"
lifecycle_condition_age = "60"

blogvoy_bucket_name = "nma-blogvoy"
blogvoy_bucket_storage_class = "REGIONAL"

network_name = "kube-network"
subnetwork_name = "kube-subnetwork"
cidr = "10.42.42.0/24"

gke_name = "nma-kube"
gke_min_master_version = "1.9.4-gke.1"
gke_node_version = "1.9.4-gke.1"

gke_node_count = "2"
gke_machine_type = "n1-standard-1"
gke_disk_size_gb = "10"
gke_preemptible = "true"
gke_auto_repair = "true"
gke_auto_upgrade = "false"

# public rproxy
rproxy_pub_name = "rproxy-pub"
rproxy_pub_machine_type = "f1-micro"
rproxy_pub_preemptible = "false"
rproxy_image_pub = "rproxy-pub-2018-04-01t16-46-21z"

# private rproxy
rproxy_priv_name = "rproxy-priv"
rproxy_priv_machine_type = "f1-micro"
rproxy_priv_preemptible = "false"
rproxy_image_priv = "rproxy-priv-2018-04-01t16-46-39z"

rproxy_http_port = "80"
rproxy_https_port = "443"
rproxy_ssh_port = "22"
ingwatcher_ports = [
  "6565",
  "6566"
]
