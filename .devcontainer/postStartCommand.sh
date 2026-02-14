#!/bin/bash
set -e

# Wait for docker
for i in {1..30}; do
    docker info &>/dev/null && break
    sleep 1
done

# Remove existing container if exists
docker rm -f windows 2>/dev/null || true

# Start Windows container
docker run -d --name windows \
  -e VERSION=11 \
  -e RAM_SIZE=8G \
  -e DISK_SIZE=64G \
  -e CPU_CORES=4 \
  --device=/dev/kvm \
  --device=/dev/net/tun \
  --cap-add NET_ADMIN \
  -p 8006:8006 \
  -p 3389:3389 \
  -v /tmp/windows:/storage \
  -v /workspaces/windows/.devcontainer/oem:/oem \
  --privileged \
  --restart on-failure \
  dockurr/windows

echo "Windows container started"
