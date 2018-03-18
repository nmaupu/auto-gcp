variable "name" {
  type        = "string"
  description = "A name for the dns zone"
}

variable "location" {
  type        = "string"
  default = "eu"
  description = "Location of the bucket (e.g. eu)"
}

variable "project" {
  type        = "string"
  description = "Project that this bucket belongs to"
}

variable "storage_class" {
  type        = "string"
  description = "Storage class (MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE)"
}

variable "versioning" {
  type        = "string"
  description = "Is this bucket versionned ?"
}
