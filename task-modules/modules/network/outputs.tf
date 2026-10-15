output "vpc_id" {
  description = "VPC id"
  value       = google_compute_network.vpc_net.id
}

output "subnet_id" {
  description = "subnet id"
  value       = google_compute_subnetwork.subnet.id
}
