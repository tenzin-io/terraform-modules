#!/bin/bash

# Perform retries if failing download
echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries

### Setup filestore

apt-get install -y nfs-common

mkdir -p ${shared_filesystem_path}
echo "${filestore_host}:${shared_filesystem_path} ${shared_filesystem_path} nfs4 rw,relatime 0 0" >> /etc/fstab

systemctl daemon-reload
mount ${shared_filesystem_path}

### Setup Kubernetes system prep

apt-get install -y ansible-core

git clone https://github.com/tenzin-io/setup-kubernetes.git
cd /setup-kubernetes/sysprep-node

cat <<'eof' > vars.yaml
eks_release_url: https://distro.eks.amazonaws.com/kubernetes-1-31/kubernetes-1-31-eks-6.yaml
eks_release_arch: amd64 # amd64 || arm64
eks_release_os: linux

containerd_version: 1.7.22
containerd_os: linux
containerd_arch: amd64 # amd64 || arm64

runc_version: 1.1.14
runc_arch: amd64 # amd64 || arm64

cni_plugins_version: 1.5.1
cni_plugins_arch: amd64 # amd64 || arm64
cni_plugins_os: linux

crictl_version: 1.31.1
crictl_arch: amd64 # amd64 || arm64
crictl_os: linux

docker_hub_user: ${docker_hub_user}
docker_hub_token: ${docker_hub_token}
eof

ansible-playbook main.yaml

### Setup Kubernetes node

cd /setup-kubernetes/cluster-node

cat <<'eof' > vars.yaml
# kubernetes
node_type: ${node_type}
skip_phase_mark_control_plane: ${skip_phase_mark_control_plane}
%{~ if length(alternative_domain_names) == 0 }
control_plane_endpoint_name: ${cluster_virtual_hostname}.${vpc_domain_name}
%{~ else }
control_plane_endpoint_name: ${cluster_virtual_hostname}.${alternative_domain_names[0]}
%{~ endif }
control_plane_endpoint_address: ${cluster_virtual_ip}
control_plane_endpoint_alternative_names:
  - "${cluster_virtual_hostname}.${vpc_domain_name}"
  %{~ for domain in alternative_domain_names ~}
  - "${cluster_virtual_hostname}.${domain}"
  %{~ endfor ~}
pod_network_cidr: 10.253.0.0/16
service_network_cidr: 10.254.0.0/16
control_plane_listen_port: ${cluster_api_listen_port}

# keepalived
enable_keepalived: True
keepalived_router_id: 100
keepalived_interface: enp1s0
keepalived_virtual_address: ${cluster_virtual_ip}
keepalived_cluster_password: clusterpass

# shared filesystem
cluster_filesystem_path: ${shared_filesystem_path}
eof

ansible-playbook main.yaml

%{ if node_type == "bootstrap_node" }
## Install platform components

apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt-get update && apt-get install -y terraform

### Setup initial platform components
cd /setup-kubernetes/platform-addons
cat <<'eof' > terraform.tfvars
cloudflare_tunnel_token = "${cloudflare_tunnel_token}"
cluster_filesystem_path = "${shared_filesystem_path}"
eof

terraform init && terraform apply -auto-approve
%{ endif }