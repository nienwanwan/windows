#!/bin/bash
set -e

# Setup directories
mkdir -p /tmp/windows
mkdir -p /workspaces/windows/.devcontainer/oem

# Create compose file with dynamic resources
cat > /tmp/windows/docker-compose.yml <<EOF
services:
  windows:
    container_name: windows
    image: dockurr/windows:latest
    environment:
      VERSION: "11"
      CPU_CORES: $(nproc --all)
      RAM_SIZE: 8G
      DISK_SIZE: 64G
      BOOT_MODE: windows
      DEBUG: Y
    ports:
      - 2222:22
      - 3389:3389/tcp
      - 3389:3389/udp
      - 8006:8006
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    volumes:
      - /tmp/windows:/storage
      - /workspaces/windows/.devcontainer/oem:/oem
    privileged: true
    restart: on-failure
    stop_grace_period: 2m
EOF

echo "Setup complete"
