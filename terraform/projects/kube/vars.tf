variable "region" {
}

## Backup bucket
variable "backup_bucket_name" {
}

variable "backup_bucket_storage_class" {
}

variable "lifecycle_condition_age" {
}

variable "network_name" {
}

variable "subnetwork_name" {
}

variable "cidr" {
}

## gke related
# Cluster
variable "gke_name" {
}

variable "gke_min_master_version" {
}

variable "gke_node_version" {
}

variable "gke_persistent_disk_csi_enabled" {
  type = bool
}


# node pool
variable "gke_node_count" {
}

variable "gke_disk_size_gb" {
}

variable "gke_machine_type" {
}

variable "gke_preemptible" {
}

variable "gke_auto_upgrade" {
}

variable "gke_auto_repair" {
}

# public rproxy
variable "rproxy_pub_name" {
}

variable "rproxy_pub_machine_type" {
}

variable "rproxy_pub_preemptible" {
}

variable "rproxy_pub_network_tier" {
}

variable "rproxy_pub_on_host_maintenance" {
}

variable "rproxy_image_pub" {
}

# private rproxy
variable "rproxy_priv_name" {
}

variable "rproxy_priv_machine_type" {
}

variable "rproxy_priv_preemptible" {
}

variable "rproxy_priv_network_tier" {
}

variable "rproxy_priv_on_host_maintenance" {
}

variable "rproxy_image_priv" {
}

variable "rproxy_priv_sources" {
  type = list(string)
}

variable "rproxy_http_port" {
}

variable "rproxy_https_port" {
}

variable "rproxy_ssh_port" {
}

variable "ingwatcher_ports" {
  type = list(string)
}
