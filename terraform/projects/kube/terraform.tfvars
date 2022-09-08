region = "europe-west1"

backup_bucket_name          = "nma-backup"
backup_bucket_storage_class = "REGIONAL"
lifecycle_condition_age     = "60"

network_name    = "kube-network"
subnetwork_name = "kube-subnetwork"
cidr            = "10.42.42.0/24"

gke_name                        = "nma-kube"
gke_min_master_version          = "1.24.3-gke.2100"
gke_node_version                = "1.24.3-gke.2100"
gke_persistent_disk_csi_enabled = true

# Number of nodes by zone
gke_node_count   = "3"
# Machines have been committed for 3 years (2022-06-23 -> 2025-06-23) using CUD (Committed Use Discount)
# CUD automatic renewal has not been activated !
# CUD has been done manually using the console (no terraform support yet)
# Parameters used:
#   - vCPU: 3 (enough for 3 machines because e2-medium has only 1 vCPU reserved and 2 vCPU burstable)
#   - RAM: 12GB (3 * 4GB)
# Reservation has also been specified (and is free because part of the CUD)
gke_machine_type = "e2-medium"
gke_disk_size_gb = "15"
gke_preemptible  = "false"
gke_auto_repair  = "true"
gke_auto_upgrade = "true"

# For rproxy machines, a 3-year-CUD has also been done (2022-06-24 -> 2025-06-24)
# No automatic renewal
# Parameters used:
#   - vCPU: 1 (enough for 2 e2-small because 0.5 cpu * 2 = 1vCPU)
#   - RAM:  4GB (2 * 2GB)
# Reservation has also been specified (and is free because part of the CUD)

# public rproxy
rproxy_pub_name                = "rproxy-pub"
rproxy_pub_machine_type        = "e2-small"
rproxy_pub_preemptible         = "false"
rproxy_pub_network_tier        = "STANDARD"
rproxy_pub_on_host_maintenance = "MIGRATE"
rproxy_image_pub               = "rproxy-pub-2022-09-08t10-08-41z"

# private rproxy
rproxy_priv_name                = "rproxy-priv"
rproxy_priv_machine_type        = "e2-small"
rproxy_priv_preemptible         = "false"
rproxy_priv_network_tier        = "STANDARD"
rproxy_priv_on_host_maintenance = "MIGRATE"
rproxy_image_priv               = "rproxy-priv-2022-09-08t10-04-31z"

rproxy_http_port  = "80"
rproxy_https_port = "443"
rproxy_ssh_port   = "22"
ingwatcher_ports = [
  "6565",
  "6566"
]
