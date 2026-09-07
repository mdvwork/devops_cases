#!/usr/bin/env bash
set -euo pipefail
[[ ${EUID} -eq 0 ]] || { echo '[FAIL] Запустите через sudo'; exit 1; }
for unit in ca-web.service legacy-web.service; do systemctl disable --now "$unit" >/dev/null 2>&1 || true; done
rm -f -- /etc/systemd/system/ca-web.service /etc/systemd/system/legacy-web.service
if [[ -d /opt/ca-yan-linux ]]; then rm -rf --one-file-system /opt/ca-yan-linux; fi
systemctl daemon-reload
systemctl reset-failed >/dev/null 2>&1 || true
echo '[OK] Ресурсы case 1 удалены'
