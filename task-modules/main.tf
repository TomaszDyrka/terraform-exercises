module "network" {
  source = "./modules/network"

  vpc_name    = "cmtr-tri7inv5-vpc"
  subnet_name = "cmtr-tri7inv5-subnet"
  region      = var.region
  subnet_cidr = "10.10.1.0/24"
}

module "network_security" {
  source = "./modules/network_security"

  vpc_id = module.network.vpc_id

  ssh_fw_name  = "cmtr-tri7inv5-ssh-fr"
  http_fw_name = "cmtr-tri7inv5-http-fr"

  allowed_ip_ranges = var.allowed_ip_ranges
}

module "application" {
  source = "./modules/application"

  network_id = module.network.vpc_id
  subnet_id  = module.network.subnet_id

  region     = var.region
  project_id = var.project_id

  template_name     = "cmtr-tri7inv5-template"
  mig_name          = "cmtr-tri7inv5-mig"
  health_check_name = "cmtr-tri7inv5-hc"
  bs_name           = "cmtr-tri7inv5-bs"
  url_map_name      = "cmtr-tri7inv5-url-map"
  http_proxy_name   = "cmtr-tri7inv5-http-proxy"
  gfr_name          = "cmtr-tri7inv5-fr"
}