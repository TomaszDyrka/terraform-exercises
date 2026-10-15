project_id = "cmtr-tri7inv5-project-505511"
region     = "europe-west3"
owner      = "tomasz_dyrka"

# networks
# --------
vpc_name         = "cmtr-tri7inv5-vpc"
pub_subnet_cidr  = "10.0.1.0/24"
priv_subnet_cidr = "10.0.2.0/24"
priv_subnet_name = "cmtr-tri7inv5-public-subnet"

# firewalls
# ---------
firewall_ssh  = "cmtr-tri7inv5-ssh-fw"
firewall_http = "cmtr-tri7inv5-http-fw"

# IAM
# ---
sa_name = "cmtr-tri7inv5-sa"

# storage bucket
# --------------
bucket_name = "cmtr-tri7inv5-bucket"

# application
# -----------
workload_policy_name = "workload-policy"
blue_template_name   = "cmtr-tri7inv5-blue-template"
green_template_name  = "cmtr-tri7inv5-green-template"
blue_mig_name        = "cmtr-tri7inv5-blue-mig"
green_mig_name       = "cmtr-tri7inv5-green-mig"
blue_bs_name         = "cmtr-tri7inv5-blue-bs"
green_bs_name        = "cmtr-tri7inv5-green-bs"
gfr_name             = "cmtr-tri7inv5-forwarding-rule"
health_check_name    = "cmtr-tri7inv5-hc"
url_map_name         = "cmtr-tri7inv5-url-map"
http_proxy_name      = "cmtr-tri7inv5-proxy"

