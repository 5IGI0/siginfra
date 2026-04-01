#!/bin/sh

podman-compose -f docker-compose.yml down
podman volume prune -f
podman unshare rm -r ./data/