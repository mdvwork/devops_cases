#!/usr/bin/env bash
set -euo pipefail
[[ ${EUID} -eq 0 ]] || { echo '[FAIL] Запустите через sudo'; exit 1; }
fail=0
report() { local label="$1"; shift; if "$@"; then echo "[OK] $label"; else echo "[FAIL] $label"; fail=1; fi; }
report 'ca-web не активен' bash -c '! systemctl is-active --quiet ca-web.service'
report 'ExecStart содержит исходный путь' bash -c "systemctl show ca-web.service -p ExecStart --value | grep -q '/opt/ca-yan-linux/start_server.sh'"
report 'start.sh не executable' bash -c '[[ ! -x /opt/ca-yan-linux/start.sh ]]'
report 'порт 8080 занят' bash -c "ss -ltn 'sport = :8080' | grep -q LISTEN"
report 'legacy-web активен' systemctl is-active --quiet legacy-web.service
exit "$fail"
