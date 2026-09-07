#!/usr/bin/env bash
set -euo pipefail
dir="${1:-$(cd "$(dirname "$0")/../student" && pwd)}"; project=yan-lab-case02-verify
[[ -f "$dir/Dockerfile" && -f "$dir/.dockerignore" && -f "$dir/compose.yaml" ]] || { echo '[FAIL] Нужны Dockerfile, .dockerignore и compose.yaml'; exit 1; }
cleanup(){ docker compose -p "$project" -f "$dir/compose.yaml" down --remove-orphans >/dev/null 2>&1 || true; }; trap cleanup EXIT
docker compose -p "$project" -f "$dir/compose.yaml" config -q
docker compose -p "$project" -f "$dir/compose.yaml" build
docker compose -p "$project" -f "$dir/compose.yaml" up -d
for _ in {1..30}; do curl -fsS --max-time 2 http://127.0.0.1:8080/health >/dev/null && break; sleep 2; done
root_json="$(curl -fsS --max-time 5 http://127.0.0.1:8080/)"; health="$(curl -fsS --max-time 5 http://127.0.0.1:8080/health)"
python3 -c 'import json,sys; d=json.loads(sys.argv[1]); assert d["service"]=="career-academy-demo" and d["status"]=="ok" and d["environment"]' "$root_json"
python3 -c 'import json,sys; assert json.loads(sys.argv[1])=={"status":"healthy"}' "$health"
container="$(docker compose -p "$project" -f "$dir/compose.yaml" ps -q app)"; [[ -n "$container" ]]
[[ "$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}missing{{end}}' "$container")" == healthy ]] || { echo '[FAIL] container не healthy'; exit 1; }
echo '[OK] Решение case 2 прошло проверку'
