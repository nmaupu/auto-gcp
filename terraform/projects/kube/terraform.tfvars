region = "europe-west1"

backup_bucket_name          = "nma-backup"
backup_bucket_storage_class = "REGIONAL"
lifecycle_condition_age     = "60"

network_name    = "kube-network"
subnetwork_name = "kube-subnetwork"
cidr            = "10.42.42.0/24"

gke_name                        = "nma-kube"
gke_min_master_version          = "1.23.6-gke.1700"
gke_node_version                = "1.23.6-gke.1700"
gke_persistent_disk_csi_enabled = true

# Number of nodes by zone
gke_node_count   = "3"
gke_machine_type = "e2-small"
gke_disk_size_gb = "15"
gke_preemptible  = "false"
gke_auto_repair  = "true"
gke_auto_upgrade = "true"

# public rproxy
rproxy_pub_name                = "rproxy-pub"
rproxy_pub_machine_type        = "f1-micro"
rproxy_pub_preemptible         = "false"
rproxy_pub_network_tier        = "STANDARD"
rproxy_pub_on_host_maintenance = "MIGRATE"
rproxy_image_pub               = "rproxy-pub-2022-06-06t15-08-58z"

# private rproxy
rproxy_priv_name                = "rproxy-priv"
rproxy_priv_machine_type        = "f1-micro"
rproxy_priv_preemptible         = "false"
rproxy_priv_network_tier        = "STANDARD"
rproxy_priv_on_host_maintenance = "MIGRATE"
rproxy_image_priv               = "rproxy-priv-2022-06-06t15-29-32z"

rproxy_http_port  = "80"
rproxy_https_port = "443"
rproxy_ssh_port   = "22"
ingwatcher_ports = [
  "6565",
  "6566"
]
