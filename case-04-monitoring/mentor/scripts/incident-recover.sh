#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../../student" && pwd)"
docker compose -p yan-lab-case04 -f "$root/docker-compose.yml" start app
for _ in {1..30}; do curl -fsS --max-time 2 http://127.0.0.1:8080/health >/dev/null && { echo '[OK] Приложение восстановлено'; exit 0; }; sleep 2; done
exit 1
