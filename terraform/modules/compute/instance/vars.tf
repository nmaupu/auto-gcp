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
  default = "true"
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

variable "subnetwork" {
  type        = "string"
  description = "subnetwork to use for that instance"
}

variable "service_account_scopes" {
  type        = "list"
  description = "Scopes to use for this instance"
}

variable "preemptible" {
  type = "string"
  default = "false"
  description = "Is machine a preemptible instance ?"
}

variable "automatic_restart" {
  type = "string"
  default = "true"
  description = "Automatically restart machine is case of google engine's event"
}
