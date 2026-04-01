#!/bin/sh

# Forgejo runners need the user-scoped Podman socket.
systemctl --user enable --now podman.socket

# Prefer rootless Podman socket to avoid /var/run/docker.sock permission issues.
PODMAN_SOCKET="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/podman/podman.sock"

if [ ! -S "$PODMAN_SOCKET" ]; then
	echo "Podman socket not found at $PODMAN_SOCKET" >&2
	exit 1
fi

export PODMAN_SOCKET
export DOCKER_HOST="unix://$PODMAN_SOCKET"

podman-compose -f docker-compose.yml up #-d