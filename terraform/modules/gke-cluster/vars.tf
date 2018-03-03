variable "name" {
  type        = "string"
  description = "A name for the resource"
}

variable "zone" {
  type        = "string"
  description = "Zone in which to install the cluster"
}

variable "initial_node_count" {
  type        = "string"
  description = "Number of nodes in the cluster"
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

variable "username" {
  type        = "string"
  description = "Master username"
}

variable "password" {
  type        = "string"
  description = "Master password"
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

variable "oauth_scopes" {
  type        = "list"
  description = "oauth scopes to bind to the VM of the cluster"
}

variable "disk_size_gb" {
  type        = "string"
  description = "local disk size"
}

variable "machine_type" {
  type        = "string"
  default     = "f1-micro"
  description = "Machine type to use"
}

variable "preemptible" {
  type        = "string"
  default     = "false"
  description = "Use preemptible instances as nodes"
}
