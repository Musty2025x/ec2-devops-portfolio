#!/usr/bin/env bash
set -euo pipefail
KNOWN_GOOD_SHA="${1:?Usage: rollback.sh <known-good-git-sha>}"
DEPLOY_DIR="${DEPLOY_DIR:-/opt/team-c-app}"
cd "$DEPLOY_DIR"
sed -i "s/^IMAGE_TAG=.*/IMAGE_TAG=${KNOWN_GOOD_SHA}/" .env
docker compose --env-file .env -f compose/server.yml pull
docker compose --env-file .env -f compose/server.yml up -d --remove-orphans
: "${HEALTH_URL:?Set HEALTH_URL to the actual application health endpoint}"
"$(dirname "$0")/healthcheck.sh" "$HEALTH_URL"
