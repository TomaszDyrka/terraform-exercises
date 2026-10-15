project_id = "cmtr-tri7inv5-project-505511"
region     = "europe-west3"
owner      = "tomasz_dyrka"

# networks
# --------
vpc_name         = "cmtr-tri7inv5-vpc"
pub_subnet_cidr  = "10.0.1.0/24"
priv_subnet_cidr = "10.0.2.0/24"
priv_subnet_name = "cmtr-tri7inv5-private-subnet"

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
template_name        = "cmtr-tri7inv5-template"
mig_name             = "cmtr-tri7inv5-mig"
gfr_name             = "cmtr-tri7inv5-fr"
health_check_name    = "cmtr-tri7inv5-hc"
bs_name              = "cmtr-tri7inv5-backend-service"
url_map_name         = "cmtr-tri7inv5-url-map"
http_proxy_name      = "cmtr-tri7inv5-proxy"

