variable "name" {
  type        = "string"
  description = "A name for the resource"
}

variable "type" {
  type        = "string"
  description = "Type of DNS entry"
}

variable "ttl" {
  type        = "string"
  description = "TTL for the dns entry"
}

variable "managed_zone" {
  type        = "string"
  description = "Corresponding Managed zone for the record"
}

variable "rrdatas" {
  type        = "list"
  description = "The string data for the records in this record set whose meaning depends on the DNS type"
}

variable "project_id" {
  type        = "string"
  description = "The project id the dns record belongs to"
}
