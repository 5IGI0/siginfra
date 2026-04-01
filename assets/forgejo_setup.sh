#!/bin/bash

###############################################################
# This script sets defaults for gitea to run in the container #
###############################################################

# It assumes that you place this script as gitea in /usr/local/bin
#
# And place the original in /usr/lib/gitea with working files in /data/gitea
GITEA="/app/gitea/gitea"
WORK_DIR="/data/gitea"
CUSTOM_PATH="/data/gitea"

export GITEA_WORK_DIR="${GITEA_WORK_DIR:-$WORK_DIR}" GITEA_CUSTOM="${GITEA_CUSTOM:-$CUSTOM_PATH}"

"$GITEA" $CONF_ARG migrate
"$GITEA" $CONF_ARG admin user create \
  --username "${FORGEJO_ADMIN_USERNAME}" \
  --password "${FORGEJO_ADMIN_PASSWORD}" \
  --email "${FORGEJO_ADMIN_EMAIL}" \
  --admin
"$GITEA" $CONF_ARG forgejo-cli actions register --keep-labels --secret "${FORGEJO_SHARED_SECRET}"

# Provide docker defaults
exec -a "$0" "$GITEA" $CONF_ARG "$@"
