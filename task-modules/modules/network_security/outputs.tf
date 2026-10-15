output "ssh_fw_id" {
  description = "ssh firewall rule id"
  value       = google_compute_firewall.ssh_firewall.id
}

output "http_fw_id" {
  description = "http firewall rule id"
  value       = google_compute_firewall.http_firewall.id
}
