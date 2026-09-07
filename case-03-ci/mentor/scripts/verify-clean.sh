#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../../student" && pwd)"; tmp="$(mktemp -d)"
cleanup(){ "$root/../mentor/scripts/remove-defect.sh" >/dev/null; rm -rf "$tmp"; }; trap cleanup EXIT
[[ ! -e "$root/.github/workflows/ci.yml" ]] || { echo '[FAIL] starter содержит workflow'; exit 1; }
python3 -m venv "$tmp/venv"; "$tmp/venv/bin/pip" -q install -r "$root/requirements.txt"
(cd "$root" && "$tmp/venv/bin/pytest" -q)
"$root/../mentor/scripts/inject-defect.sh" >/dev/null
set +e; (cd "$root" && "$tmp/venv/bin/pytest" -q) >"$tmp/log" 2>&1; rc=$?; set -e
[[ $rc -ne 0 ]] || { echo '[FAIL] Дефект не ломает тест'; exit 1; }
grep -Eq '1 failed, [0-9]+ passed' "$tmp/log" || { cat "$tmp/log"; echo '[FAIL] Должен падать ровно один тест'; exit 1; }
"$root/../mentor/scripts/remove-defect.sh" >/dev/null
(cd "$root" && "$tmp/venv/bin/pytest" -q)
echo '[OK] Case 3 чист; дефект обратим и ломает ровно один тест'
