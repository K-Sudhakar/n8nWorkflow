#!/usr/bin/env sh
set -eu

TARGET_URL="${1:-http://localhost:5678/healthz}"
MAX_RETRIES="${MAX_RETRIES:-30}"
SLEEP_SECONDS="${SLEEP_SECONDS:-2}"

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required for this test script."
  exit 1
fi

echo "Checking n8n health at ${TARGET_URL}..."

retry=1
while [ "$retry" -le "$MAX_RETRIES" ]; do
  if curl -fsS "$TARGET_URL" >/dev/null; then
    echo "n8n is healthy and reachable."
    exit 0
  fi

  echo "Attempt ${retry}/${MAX_RETRIES} failed; retrying in ${SLEEP_SECONDS}s..."
  retry=$((retry + 1))
  sleep "$SLEEP_SECONDS"
done

echo "n8n did not become healthy in time."
exit 1