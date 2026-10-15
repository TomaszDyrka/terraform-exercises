resource "google_compute_global_address" "lb_ipv4" {
  name = "${var.gfr_name}-ip"
}

resource "google_compute_instance_template" "main_template" {
  name         = var.template_name
  machine_type = "e2-micro"

  tags = ["web-instances"]

  disk {
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnet_id

    access_config {
      # Wymusza publiczne IP
    }
  }

  metadata = {
    startup-script = file("${path.module}/files/userdata.sh")
  }

  labels = local.resource_labels
}

resource "google_compute_region_instance_group_manager" "main_mig" {
  name               = var.mig_name
  region             = var.region
  base_instance_name = "app-instance"

  version {
    instance_template = google_compute_instance_template.main_template.self_link_unique
  }

  target_size = 2

  named_port {
    name = "http"
    port = 80
  }

  lifecycle {
    ignore_changes = [target_size]
  }
}

resource "google_compute_health_check" "http_health_check" {
  name = var.health_check_name

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "backend_mig_service" {
  name = var.bs_name

  health_checks = [google_compute_health_check.http_health_check.self_link]

  backend {
    group = google_compute_region_instance_group_manager.main_mig.instance_group
  }
}

resource "google_compute_url_map" "url_map_default" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.backend_mig_service.id
}

resource "google_compute_target_http_proxy" "proxy_default" {
  name    = var.http_proxy_name
  url_map = google_compute_url_map.url_map_default.id
}

resource "google_compute_global_forwarding_rule" "gfr_default" {
  name                  = var.gfr_name
  target                = google_compute_target_http_proxy.proxy_default.id
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  ip_address            = google_compute_global_address.lb_ipv4.id
}