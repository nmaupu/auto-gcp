variable "project_name" {
  type        = string
  description = "Project name"
}

variable "billing_account" {
  type        = string
  description = "Billing account to bind project to"
}

variable "org_id" {
  type        = string
  description = "Organization in which to create project"
}

