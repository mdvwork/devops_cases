#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../../student" && pwd)"; file="$root/app/main.py"
[[ -f "$file" ]] || { echo '[FAIL] app/main.py не найден'; exit 1; }
sed -i 's/min(99, value)/min(100, value)/' "$file"
echo '[OK] Чистая реализация восстановлена'
