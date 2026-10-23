#!/usr/bin/env bash
set -euo pipefail
DEPLOY_DIR="${DEPLOY_DIR:-/opt/team-c-app}"
COMPOSE_FILE="${COMPOSE_FILE:-compose/server.yml}"
IMAGE_TAG="${1:?Usage: deploy.sh <git-sha>}"
cd "$DEPLOY_DIR"
export IMAGE_TAG
docker compose --env-file .env -f "$COMPOSE_FILE" pull
docker compose --env-file .env -f "$COMPOSE_FILE" up -d --remove-orphans
# Set HEALTH_URL in the server environment to the app's real health endpoint.
: "${HEALTH_URL:?Set HEALTH_URL to the actual application health endpoint}"
"$(dirname "$0")/healthcheck.sh" "$HEALTH_URL"
docker image prune -f
