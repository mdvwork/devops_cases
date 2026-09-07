#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"; dist="$root/dist"
command -v zip >/dev/null && command -v unzip >/dev/null || { echo '[FAIL] Нужны zip и unzip'; exit 1; }
rm -rf -- "$dist"; mkdir -p "$dist"
for item in 01:linux 02:docker 03:ci 04:monitoring; do
 n="${item%%:*}"; slug="${item#*:}"; source="$root/case-$n-$slug/student"; archive="$dist/yan-case-$n-$slug.zip"
 (cd "$source" && zip -qr "$archive" . -x '*.pyc' '*/__pycache__/*' '.pytest_cache/*' '.venv/*' '.git/*')
 listing="$(unzip -Z1 "$archive")"
 grep -Eiq '(^|/)(mentor|solution|reference)(/|$)|FINAL_REPORT\.md$' <<<"$listing" && { echo '[FAIL] Закрытые материалы'; exit 1; }
 [[ "$n" != 02 ]] || ! grep -Eq '(^|/)(Dockerfile|compose\.ya?ml|docker-compose\.ya?ml|\.dockerignore)$' <<<"$listing" || { echo '[FAIL] Case 2 содержит решение'; exit 1; }
 [[ "$n" != 03 ]] || ! grep -Eq '(^|/)\.github/workflows/' <<<"$listing" || { echo '[FAIL] Case 3 содержит workflow'; exit 1; }
 [[ "$n" != 04 ]] || ! grep -Eiq 'dashboard.*\.json$' <<<"$listing" || { echo '[FAIL] Case 4 содержит dashboard'; exit 1; }
 echo "[OK] Создан $(basename "$archive")"
done
