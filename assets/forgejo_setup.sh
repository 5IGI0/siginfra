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

# TODO: this script is actuall run everything forgejo is ran.
#       So it is also called when a git hook is triggered.
#       Fix it to run only when the container is started, not on git hooks.

export GITEA_WORK_DIR="${GITEA_WORK_DIR:-$WORK_DIR}" GITEA_CUSTOM="${GITEA_CUSTOM:-$CUSTOM_PATH}"

wait_for_db() {
  # Try running gitea migrate until the DB is available. This handles
  # "the database system is starting up" transient errors.
  until "$GITEA" $CONF_ARG migrate >/dev/null 2>&1; do
    echo "Waiting for database to become available..."
    sleep 2
  done
}

wait_for_db

"$GITEA" $CONF_ARG admin user create \
  --username "${FORGEJO_ADMIN_USERNAME}" \
  --password "${FORGEJO_ADMIN_PASSWORD}" \
  --email "${FORGEJO_ADMIN_EMAIL}" \
  --admin
"$GITEA" $CONF_ARG forgejo-cli actions register --keep-labels --secret "${FORGEJO_SHARED_SECRET}"

# Provide docker defaults
exec -a "$0" "$GITEA" $CONF_ARG "$@"
