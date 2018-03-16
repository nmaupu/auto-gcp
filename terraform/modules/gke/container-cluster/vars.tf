variable "name" {
  type        = "string"
  description = "A name for the resource"
}

variable "zone" {
  type        = "string"
  description = "Zone in which to install the cluster"
}

variable "additional_zones" {
  type        = "list"
  description = "Additional zones for nodes creation"
}

variable "min_master_version" {
  type        = "string"
  description = "Minimal version of the kubernetes cluster"
}

variable "node_version" {
  type        = "string"
  description = "Version of the kubernetes nodes"
}

variable "network" {
  type        = "string"
  description = "Network to use for VMs"
}

variable "subnetwork" {
  type        = "string"
  description = "Subnetwork to use"
}

variable "project" {
  type        = "string"
  description = "Project to put cluster into"
}
