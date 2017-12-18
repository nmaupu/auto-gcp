variable "credentials" {
  type        = "map"
  description = "List of users and their public key"
}

variable "project" {
  type        = "string"
  description = "Project to bind to"
}
