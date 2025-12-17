#!/bin/bash
set -e

# Start SSH
/usr/sbin/sshd

# Create swap
swapoff /tmp/swap 2>/dev/null || true
fallocate -l 16G /tmp/swap
chmod 600 /tmp/swap
mkswap /tmp/swap
swapon /tmp/swap

# Start dockerd
rm -f /var/run/docker.pid
dockerd &>/dev/null &

# Wait for docker
echo "Waiting for Docker..."
for i in {1..30}; do
    docker info &>/dev/null && break
    sleep 1
done

# Start Windows container
cd /tmp/windows
docker compose up -d

echo "Windows container started. Access via port 8006"
