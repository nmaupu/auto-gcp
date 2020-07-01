region = "europe-west1"

backup_bucket_name          = "nma-backup"
backup_bucket_storage_class = "REGIONAL"
lifecycle_condition_age     = "60"

network_name    = "kube-network"
subnetwork_name = "kube-subnetwork"
cidr            = "10.42.42.0/24"

gke_name               = "nma-kube"
gke_min_master_version = "1.16.10-gke.8"
gke_node_version       = "1.16.10-gke.8"

# Number of nodes by zone
gke_node_count   = "2"
gke_machine_type = "e2-medium"
gke_disk_size_gb = "10"
gke_preemptible  = "true"
gke_auto_repair  = "true"
gke_auto_upgrade = "true"

# public rproxy
rproxy_pub_name         = "rproxy-pub"
rproxy_pub_machine_type = "f1-micro"
rproxy_pub_preemptible  = "false"
rproxy_pub_network_tier = "STANDARD"
rproxy_pub_on_host_maintenance = "MIGRATE"
rproxy_image_pub        = "rproxy-pub-2020-02-21t17-11-32z"

# private rproxy
rproxy_priv_name         = "rproxy-priv"
rproxy_priv_machine_type = "f1-micro"
rproxy_priv_preemptible  = "false"
rproxy_priv_network_tier = "STANDARD"
rproxy_priv_on_host_maintenance = "MIGRATE"
rproxy_image_priv        = "rproxy-priv-2020-02-21t17-02-21z"

rproxy_http_port  = "80"
rproxy_https_port = "443"
rproxy_ssh_port   = "22"
ingwatcher_ports = [
  "6565",
  "6566"
]
