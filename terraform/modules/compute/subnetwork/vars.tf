variable "name" {
  type        = string
  description = "A name for the resource"
}

variable "network" {
  type        = string
  description = "The network name or parent network"
}

variable "ip_cidr_range" {
  type        = string
  description = "cidr for this subnetwork"
}

variable "project" {
  type        = string
  description = "A project to create network resource into"
}

