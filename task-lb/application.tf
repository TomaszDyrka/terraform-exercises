data "google_service_account" "sa" {
  account_id = var.sa_name
}

data "google_compute_subnetwork" "private-subnet" {
  name = var.priv_subnet_name
}

resource "google_compute_global_address" "lb-ipv4" {
  name = "${var.gfr_name}-ip"
}

resource "google_compute_instance_template" "main-template" {
  name         = var.template_name
  machine_type = "e2-medium"

  tags = ["web-instances"]

  disk {
    source_image = "debian-cloud/debian-11"
  }

  service_account {
    email  = data.google_service_account.sa.email
    scopes = ["cloud-platform"]
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = data.google_compute_subnetwork.private-subnet.id

    access_config {
    }
  }

  # almost the same as in task7 gcp
  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx

    INSTANCE_ID=$(curl -s -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/id")
    PRIVATE_IP=$(curl -s -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip")

    cat <<EOF > /var/www/html/index.html
    This message was generated on instance $INSTANCE_ID with the following IP: $PRIVATE_IP
    EOF

    gsutil cp /var/www/html/index.html gs://${var.bucket_name}/$INSTANCE_ID.html
  EOT

  labels = local.resource_labels
}


resource "google_compute_region_instance_group_manager" "main-mig" {
  name               = var.mig_name
  region             = var.region
  base_instance_name = "app-instance"

  version {
    instance_template = google_compute_instance_template.main-template.self_link_unique
  }

  target_size = 2

  named_port {
    name = "http"
    port = 80
  }
}


resource "google_compute_health_check" "http-health-check" {
  name = var.health_check_name

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "backend-mig-service" {
  name = var.bs_name

  health_checks = [google_compute_health_check.http-health-check.self_link]

  backend {
    group = google_compute_region_instance_group_manager.main-mig.instance_group
  }
}

resource "google_compute_url_map" "url-map-default" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.backend-mig-service.id
}

resource "google_compute_target_http_proxy" "proxy-default" {
  name    = var.http_proxy_name
  url_map = google_compute_url_map.url-map-default.id
}


resource "google_compute_global_forwarding_rule" "gfr-default" {
  name                  = var.gfr_name
  project               = var.project_id
  target                = google_compute_target_http_proxy.proxy-default.id
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  ip_address            = google_compute_global_address.lb-ipv4.id

  labels = local.resource_labels
}
