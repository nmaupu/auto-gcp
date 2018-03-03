##
# Variables
##
variable "region" {}

variable "network_name" {}
variable "subnetwork_name" {}
variable "cidr" {}

variable "gke_name" {}
variable "gke_initial_node_count" {}
variable "gke_min_master_version" {}
variable "gke_node_version" {}
variable "gke_preemptible" {}
variable "gke_username" {}
variable "gke_password" {}
variable "gke_disk_size_gb" {}
variable "gke_machine_type" {}

# public rproxy
variable "rproxy_pub_name" {}
variable "rproxy_pub_machine_type" {}
variable "rproxy_pub_preemptible" {}
variable "rproxy_image_pub" {}

# private rproxy
variable "rproxy_priv_name" {}
variable "rproxy_priv_machine_type" {}
variable "rproxy_priv_preemptible" {}
variable "rproxy_image_priv" {}
variable "rproxy_priv_sources" {
  type = "list"
}

variable "rproxy_http_port" {}
variable "rproxy_https_port" {}
variable "rproxy_ssh_port" {}
