#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../../student" && pwd)"; file="$root/app/main.py"
[[ -f "$file" ]] || { echo '[FAIL] app/main.py не найден'; exit 1; }
grep -q 'return max(0, min(100, value))' "$file" || { echo '[FAIL] Ожидалось чистое состояние'; exit 1; }
sed -i 's/min(100, value)/min(99, value)/' "$file"
echo '[OK] Контролируемое изменение внесено'
