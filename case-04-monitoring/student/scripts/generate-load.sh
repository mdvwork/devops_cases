#!/usr/bin/env bash
set -euo pipefail
url="${1:-http://127.0.0.1:8080/}"; count="${2:-100}"
[[ "$count" =~ ^[1-9][0-9]*$ && "$count" -le 500 ]] || { echo '[FAIL] Количество должно быть от 1 до 500'; exit 1; }
for ((i=1; i<=count; i++)); do curl -fsS --max-time 3 "$url" >/dev/null; sleep 0.05; done
echo "[OK] Выполнено $count локальных запросов"
