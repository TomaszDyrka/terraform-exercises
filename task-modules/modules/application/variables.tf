variable "network_id" {
  description = "network id"
  type        = string
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "template_name" {
  type = string
}

variable "mig_name" {
  type = string
}

variable "health_check_name" {
  type = string
}

variable "bs_name" {
  type = string
}

variable "url_map_name" {
  type = string
}

variable "http_proxy_name" {
  type = string
}

variable "gfr_name" {
  type = string
}