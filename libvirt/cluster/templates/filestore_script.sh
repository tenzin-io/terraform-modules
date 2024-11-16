#!/bin/bash

# Update package cache and install packages
apt-get update
apt-get install -y nfs-common nfs-kernel-server

mkdir -p /data/shared

cat <<'EOF' > /etc/exports
/data/shared ${filestore_clients}(rw,no_subtree_check,no_root_squash)
EOF
exportfs -ra

systemctl enable nfs-server
systemctl start nfs-server