#!/bin/bash

# Update package cache and install packages
apt-get update
apt-get install -y nfs-common

mkdir -p /data/shared
cat <<'EOF' >> /etc/fstab
${filestore_host}:/data/shared /data/shared nfs4 rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,local_lock=none 0 0
EOF

systemctl daemon-reload
mount /data/shared