# Cluster will be created multi-zonal but with a monozone master
# based on region_location variable
variable "master_location" {
  type = string
  description = "Region/zone in which to create the cluster's control plane"
}
variable "nodes_location" {
  type = list(string)
  description = "Additional zones within the region in which to create nodes"
  default = []
}

variable "name" {
  type        = string
  description = "A name for the resource"
}

variable "min_master_version" {
  type        = string
  description = "Minimal version of the kubernetes cluster"
}

variable "node_version" {
  type        = string
  description = "Version of the kubernetes nodes"
}

variable "network" {
  type        = string
  description = "Network to use for VMs"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork to use"
}

variable "project" {
  type        = string
  description = "Project to put cluster into"
}

