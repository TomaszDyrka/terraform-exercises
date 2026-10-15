#!/bin/bash
apt-get update -y
apt-get install -y nginx

systemctl enable nginx
systemctl start nginx

COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
COMPUTE_INSTANCE_ID=$(curl -s -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/id")

cat <<EOF > /var/www/html/index.html
This message was generated on instance ${COMPUTE_INSTANCE_ID} with the following UUID ${COMPUTE_MACHINE_UUID}
EOF