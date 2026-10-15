resource "google_compute_network" "vpc_net" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.vpc_net.id
  ip_cidr_range = var.subnet_cidr
}
