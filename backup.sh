#!/bin/sh

mkdir -p backups/

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="backups/$TIMESTAMP.tar.gz"

podman-compose -f docker-compose.yml down
sleep 5
podman unshare tar -czvf "$BACKUP_FILE" ./data/
podman unshare chown -R "$UID:$GID" "$BACKUP_FILE"
echo "Backup created at $BACKUP_FILE"
podman-compose -f docker-compose.yml up -d