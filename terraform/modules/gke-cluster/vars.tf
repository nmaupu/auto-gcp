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

variable "node_count" {
  type        = "string"
  description = "Number of nodes to create per group"
}

variable "auto_repair" {
  type        = "string"
  description = "Activate management auto repair feature"
}

variable "auto_upgrade" {
  type        = "string"
  description = "Activate management auto upgrade feature"
}

variable "oauth_scopes" {
  type        = "list"
  description = "Scopes to associate with created VMs"
}

variable "machine_type" {
  type        = "string"
  default     = "f1-micro"
  description = "Machine type to create"
}

variable "project" {
  type        = "string"
  description = "Project to put cluster into"
}

variable "disk_size_gb" {
  type        = "string"
  description = "local disk size"
}

variable "preemptible" {
  type        = "string"
  default     = "true"
  description = "Specifies whether create VMs are preemptible or not"
}
