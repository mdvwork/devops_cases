#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../student" && pwd)"; compose="$root/docker-compose.yml"; project=yan-lab-case04-verify
cleanup(){ docker compose -p "$project" -f "$compose" down --remove-orphans >/dev/null 2>&1 || true; }; trap cleanup EXIT
docker compose -p "$project" -f "$compose" config -q
docker compose -p "$project" -f "$compose" up --build -d
wait_url(){ for _ in {1..45}; do curl -fsS --max-time 3 "$2" >/dev/null && { echo "[OK] $1"; return; }; sleep 2; done; return 1; }
wait_url app http://127.0.0.1:8080/health
wait_url metrics http://127.0.0.1:8080/metrics/
wait_url Prometheus http://127.0.0.1:9090/-/ready
wait_url Grafana http://127.0.0.1:3000/api/health
curl -fsS http://127.0.0.1:8080/metrics/ | grep -q http_requests_total
curl -fsS http://127.0.0.1:9090/api/v1/targets | python3 -c 'import json,sys; d=json.load(sys.stdin); assert not any(t.get("labels",{}).get("job")=="app" for t in d["data"]["activeTargets"])'
echo '[OK] Case 4 starter работает и не содержит app target'
