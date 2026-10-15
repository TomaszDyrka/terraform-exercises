output "lb_id" {
  description = "Load Balancer id"
  value       = google_compute_global_address.lb_ipv4.address
}