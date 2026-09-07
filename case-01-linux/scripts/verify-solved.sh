#!/usr/bin/env bash
set -euo pipefail
[[ ${EUID} -eq 0 ]] || { echo '[FAIL] Запустите через sudo'; exit 1; }
fail=0
report() { local label="$1"; shift; if "$@"; then echo "[OK] $label"; else echo "[FAIL] $label"; fail=1; fi; }
report 'ca-web активен' systemctl is-active --quiet ca-web.service
report 'start.sh executable' test -x /opt/ca-yan-linux/start.sh
report 'legacy-web не активен' bash -c '! systemctl is-active --quiet legacy-web.service'
body="$(curl --fail --silent --max-time 5 http://127.0.0.1:8080 || true)"
if [[ "$body" == *'Career Academy'* && "$body" == *'Service is working'* ]]; then echo '[OK] Страница отвечает ожидаемым содержимым'; else echo '[FAIL] Страница недоступна или неверна'; fail=1; fi
pid="$(systemctl show ca-web.service -p MainPID --value)"
if [[ "$pid" =~ ^[1-9][0-9]*$ ]] && ss -ltnp 'sport = :8080' | grep -q "pid=$pid"; then echo '[OK] Порт принадлежит ca-web'; else echo '[FAIL] Нельзя подтвердить владельца порта'; fail=1; fi
exit "$fail"
