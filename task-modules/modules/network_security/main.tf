resource "google_compute_firewall" "ssh_firewall" {
  name    = var.ssh_fw_name
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.allowed_ip_ranges
}

resource "google_compute_firewall" "http_firewall" {
  name    = var.http_fw_name
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = var.allowed_ip_ranges
}
