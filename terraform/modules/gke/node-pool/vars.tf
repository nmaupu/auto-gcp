variable "project" {
  type        = string
  description = "Project to put cluster into"
}

variable "name_prefix" {
  type        = string
  description = "A name prefix for the resource"
}

variable "location" {
  type        = string
  description = "Location corresponding to the parent cluster"
}

variable "cluster" {
  type        = string
  description = "Cluster corresponding to this node pool"
}

variable "node_count" {
  type        = string
  description = "Number of nodes to create"
}

variable "nodes_version" {
  type        = string
  description = "Version of nodes in the node pool"
}

variable "machine_type" {
  type        = string
  default     = "f1-micro"
  description = "Machine type to create"
}

variable "disk_size_gb" {
  type        = string
  description = "local disk size"
}

variable "oauth_scopes" {
  type        = list(string)
  description = "Scopes to associate with created VMs"
}

variable "preemptible" {
  type        = string
  default     = "true"
  description = "Specifies whether create VMs are preemptible or not"
}

variable "auto_repair" {
  type        = string
  default     = "false"
  description = "Activate management auto upgrade feature"
}

variable "auto_upgrade" {
  type        = string
  default     = "false"
  description = "Activate management auto upgrade feature"
}

variable "tags" {
  type = list(string)
  default = []
  description = "Add tags to instance VMs of the node pool"
}
