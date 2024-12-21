#!/bin/bash

# perform retries if failing download
echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries

# setup tailscale
# install tailscale - https://tailscale.com/download/linux
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
apt-get update
apt-get install -y tailscale

# join tailnet
%{ if length(tailscale_auth_key) > 0 }
tailscale up --authkey ${tailscale_auth_key}
%{ endif }

# setup cloudflare
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
dpkg -i cloudflared.deb

# join cloudflare tunnel
%{ if length(cloudflare_tunnel_token) > 0 }
cloudflared service install ${cloudflare_tunnel_token}
%{ endif }

# install docker
apt-get install -y docker.io docker-compose

# setup squid service
test -d /services || mkdir /services
cd /services

cat <<'eof' > squid.conf
# Squid configuration settings
http_port 3128
visible_hostname squid

# Access control
http_access allow all
icp_access deny all
eof

cat <<'eof' > docker-compose.yaml
services:
  squid:
    image: ubuntu/squid:5.2-22.04_beta
    container_name: squid
    restart: unless-stopped
    ports:
      - 3128:3128
    environment:
      TZ: US/Eastern
    volumes:
      - ./squid.conf:/etc/squid/squid.conf:ro
eof

docker-compose up -d