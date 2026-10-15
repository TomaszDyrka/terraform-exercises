variable "project_id" {
  type        = string
  description = "Project identifier"
}

variable "region" {
  type        = string
  description = "GCP region for resources"
}

variable "owner" {
  type        = string
  description = "GCP owner"
}

# networks
# --------
variable "vpc_name" {
  type        = string
  description = "Preconfigured vpc"
}

variable "priv_subnet_name" {
  type        = string
  description = "Private subnet name"
}

variable "priv_subnet_cidr" {
  type        = string
  description = "Private subnet cidr"
}

variable "pub_subnet_cidr" {
  type        = string
  description = "Preconfigured public cidr"
}

# firewalls
# ---------

variable "firewall_ssh" {
  type        = string
  description = "Preconfigured firewall for ssh access"
}

variable "firewall_http" {
  type        = string
  description = "Preconfigured firewall for http access"
}

# IAM
# ---

variable "sa_name" {
  type        = string
  description = "Preconfigured service account"
}

# storage bucket
# --------------

variable "bucket_name" {
  type        = string
  description = "Preconfigured storage bucket"
}

# application
# -----------

variable "template_name" {
  type        = string
  description = "Template name"
}

variable "workload_policy_name" {
  type        = string
  description = "Workload policy name"
}

variable "mig_name" {
  type        = string
  description = "Managed instance group name"
}
variable "health_check_name" {
  type        = string
  description = "Health check name"
}

variable "bs_name" {
  type        = string
  description = "Backend service name"
}

variable "url_map_name" {
  type        = string
  description = "URL map name"
}

variable "http_proxy_name" {
  type        = string
  description = "Target HTTP proxy name"
}

variable "gfr_name" {
  type        = string
  description = "Global forwarding rule name"
}
