#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"; fail=0
run(){ echo "== $1 =="; local name="$1"; shift; if timeout 600 "$@"; then echo "[OK] $name"; else echo "[FAIL] $name"; fail=1; fi; }
run packages "$root/scripts/build-student-packages.sh"
run case-02-starter "$root/case-02-docker/scripts/verify-starter.sh"
run case-03 "$root/case-03-ci/mentor/scripts/verify-clean.sh"
if command -v docker >/dev/null && docker info >/dev/null 2>&1; then run case-04 "$root/case-04-monitoring/scripts/verify-stack.sh"; else echo '[SKIP] Docker runtime недоступен'; fi
if [[ "$(ps -p 1 -o comm= 2>/dev/null | tr -d ' ')" == systemd && ${EUID} -eq 0 ]]; then run case-01 "$root/case-01-linux/scripts/verify-broken.sh"; else echo '[SKIP] Case 1 требует systemd, root и установленный стенд'; fi
exit "$fail"
