variable "name" {
  type        = "string"
  description = "A name for the dns zone"
}

variable "dns_name" {
  type        = "string"
  description = "DNS name associated to the zone"
}

variable "project_id" {
  type        = "string"
  description = "Project resource that this zone belongs to"
}
