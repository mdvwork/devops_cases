#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../../student" && pwd)"
docker compose -p yan-lab-case04 -f "$root/docker-compose.yml" stop app
echo '[OK] Приложение остановлено; дождитесь scrape interval'
