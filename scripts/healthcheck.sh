#!/usr/bin/env bash
set -euo pipefail
URL="${1:?Usage: healthcheck.sh URL [attempts]}"
ATTEMPTS="${2:-12}"
for attempt in $(seq 1 "$ATTEMPTS"); do
  code="$(curl --silent --output /dev/null --write-out '%{http_code}' --max-time 5 "$URL" || true)"
  if [[ "$code" == "200" ]]; then
    echo "Health check passed: $URL"
    exit 0
  fi
  echo "Attempt ${attempt}/${ATTEMPTS}: HTTP ${code:-no response}"
  sleep 5
done
echo "Health check failed: $URL" >&2
exit 1
