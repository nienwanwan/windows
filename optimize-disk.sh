#!/bin/bash

echo "=== Disk Optimization Script ==="

# Create storage directory on larger partition
sudo mkdir -p /tmp/windows-storage
sudo chown $(whoami):$(whoami) /tmp/windows-storage

# Clean up Docker
echo "Cleaning Docker system..."
docker system prune -f
docker volume prune -f

# Stop and remove existing windows container if running
docker stop windows 2>/dev/null || true
docker rm windows 2>/dev/null || true

echo "=== Current Disk Usage ==="
df -h

echo "=== Docker Disk Usage ==="
docker system df

echo "Use compose.optimized.yml to start Windows VM with:"
echo "docker-compose -f compose.optimized.yml up -d"
