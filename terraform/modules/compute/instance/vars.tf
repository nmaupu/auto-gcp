variable "name" {
  type        = "string"
  description = "A name for the resource"
}

variable "machine_type" {
  type        = "string"
  description = "Machine type"
}

variable "allow_stopping_for_update" {
  type        = "string"
  description = "Allow stopping instance for updating a property"
  default     = "true"
}

variable "zone" {
  type        = "string"
  description = "The zone to deploy the instance into"
}

variable "project" {
  type        = "string"
  description = "The project instance belongs to"
}

variable "tags" {
  type        = "list"
  description = "Tags associated to the resource"
}

variable "image" {
  type        = "string"
  description = "Image associated to this instance"
}

variable "attached_disk_source" {
  type        = "string"
  description = "Disk to attach to the instance"
}

variable "attached_disk_device_name" {
  type        = "string"
  description = "Device name to bind under /dev/disk/by-id/"
}

variable "startup_script" {
  type        = "string"
  default     = ""
  description = "Script to execute when machine starts"
}

variable "subnetwork" {
  type        = "string"
  description = "subnetwork to use for that instance"
}

variable "access_config" {
  type        = "map"
  default = {}
  description = "Access config to use for that instance"
}

variable "service_account_scopes" {
  type        = "list"
  description = "Scopes to use for this instance"
}

variable "preemptible" {
  type        = "string"
  default     = "false"
  description = "Is machine a preemptible instance ?"
}

variable "automatic_restart" {
  type        = "string"
  default     = "true"
  description = "Automatically restart machine is case of google engine's event"
}

variable "on_host_maintenance" {
  type        = "string"
  default     = "MIGRATE"
  description = "MIGRATE or TERMINATE when a maintenance event occurs"
}
