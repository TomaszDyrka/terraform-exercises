variable "allowed_ip_ranges" {
  description = "Allowed ip ranges in this project"
  type        = list(string)
}

variable "region" {
  description = "Region for gcp resources"
  type        = string
}

variable "project_id" {
  description = "This gcp project id"
  type        = string
}