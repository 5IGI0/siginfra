#!/bin/sh

mkdir -p data/forgejo data/keycloak data/postgres
chmod g+rwx data/forgejo data/keycloak data/postgres

podman-compose -f docker-compose.yml up #-d