#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../../student" && pwd)"; compose="$root/docker-compose.yml"; project=yan-lab-case04
cleanup(){ docker compose -p "$project" -f "$compose" down --remove-orphans >/dev/null 2>&1 || true; }; trap cleanup EXIT
docker compose -p "$project" -f "$compose" up --build -d
for _ in {1..45}; do
 data="$(curl -fsS --max-time 3 http://127.0.0.1:9090/api/v1/targets 2>/dev/null || true)"
 python3 -c 'import json,sys; d=json.loads(sys.argv[1]); assert any(t.get("labels",{}).get("job")=="app" and t.get("health")=="up" for t in d["data"]["activeTargets"])' "$data" 2>/dev/null && { echo '[OK] Target app UP'; exit 0; }
 sleep 2
done
exit 1
