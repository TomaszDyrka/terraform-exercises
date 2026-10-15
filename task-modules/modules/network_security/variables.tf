variable "ssh_fw_name" {
  type        = string
  description = "ssh firewall name"
}

variable "http_fw_name" {
  type        = string
  description = "http firewall name"
}

variable "allowed_ip_ranges" {
  type        = list(string)
  description = "ip ranges list"
}

variable "vpc_id" {
  type        = string
  description = "vpc ip"
}
