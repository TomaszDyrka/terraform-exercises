data "google_compute_subnetwork" "private-subnet" {
  name = var.priv_subnet_name
}

resource "google_compute_global_address" "lb-ipv4" {
  name = "${var.gfr_name}-ip"
}

# ----------------------
resource "google_compute_instance_template" "blue-template" {
  name         = var.blue_template_name
  machine_type = "e2-medium"

  tags = ["web-instances"]

  disk {
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = data.google_compute_subnetwork.private-subnet.id

    access_config {
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx

    cat <<EOF > /var/www/html/index.html
    Blue Environment
    EOF
  EOT

  labels = local.resource_labels
}

resource "google_compute_region_instance_group_manager" "blue-mig" {
  name               = var.blue_mig_name
  region             = var.region
  base_instance_name = "blue-app-instance"

  version {
    instance_template = google_compute_instance_template.blue-template.self_link_unique
  }

  target_size = 2

  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_backend_service" "blue-backend-mig-service" {
  name = var.blue_bs_name

  health_checks         = [google_compute_health_check.http-health-check.self_link]
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group = google_compute_region_instance_group_manager.blue-mig.instance_group
  }
}

# ----------------------
resource "google_compute_instance_template" "green-template" {
  name         = var.green_template_name
  machine_type = "e2-medium"

  tags = ["web-instances"]

  disk {
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = data.google_compute_subnetwork.private-subnet.id

    access_config {
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx

    cat <<EOF > /var/www/html/index.html
    Green Environment
    EOF
  EOT

  labels = local.resource_labels
}

resource "google_compute_region_instance_group_manager" "green-mig" {
  name               = var.green_mig_name
  region             = var.region
  base_instance_name = "green-app-instance"

  version {
    instance_template = google_compute_instance_template.green-template.self_link_unique
  }

  target_size = 2

  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_backend_service" "green-backend-mig-service" {
  name = var.green_bs_name

  health_checks         = [google_compute_health_check.http-health-check.self_link]
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group = google_compute_region_instance_group_manager.green-mig.instance_group
  }
}

# -----------------
# rest
# -----------------

resource "google_compute_health_check" "http-health-check" {
  name = var.health_check_name

  http_health_check {
    port = 80
  }
}

resource "google_compute_url_map" "url-map-default" {
  name = var.url_map_name

  default_route_action {
    weighted_backend_services {
      backend_service = google_compute_backend_service.blue-backend-mig-service.id
      weight          = var.blue_weight
    }

    weighted_backend_services {
      backend_service = google_compute_backend_service.green-backend-mig-service.id
      weight          = var.green_weight
    }
  }

}

resource "google_compute_target_http_proxy" "proxy-default" {
  name    = var.http_proxy_name
  url_map = google_compute_url_map.url-map-default.id
}


resource "google_compute_global_forwarding_rule" "gfr-default" {
  name                  = var.gfr_name
  project               = var.project_id
  target                = google_compute_target_http_proxy.proxy-default.id
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  ip_address            = google_compute_global_address.lb-ipv4.id

  labels = local.resource_labels
}
