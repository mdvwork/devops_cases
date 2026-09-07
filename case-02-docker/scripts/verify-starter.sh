#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"; student="$root/student"; tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
for forbidden in Dockerfile compose.yaml docker-compose.yml .dockerignore; do [[ ! -e "$student/$forbidden" ]] || { echo "[FAIL] starter содержит $forbidden"; exit 1; }; done
python3 -m venv "$tmp/venv"; "$tmp/venv/bin/pip" -q install -r "$student/app/requirements.txt"
(cd "$student/app" && "$tmp/venv/bin/pytest" -q)
echo '[OK] Case 2 starter чист и тесты проходят'
