#!/usr/bin/env bash
set -euo pipefail
[[ ${EUID} -eq 0 ]] || { echo '[FAIL] Запустите через sudo'; exit 1; }
[[ -d /opt/ca-yan-linux && -f /opt/ca-yan-linux/start.sh ]] || { echo '[FAIL] Сначала выполните setup.sh'; exit 1; }
systemctl disable --now ca-web.service >/dev/null 2>&1 || true
systemctl disable --now legacy-web.service >/dev/null 2>&1 || true
cat > /etc/systemd/system/ca-web.service <<'EOF'
[Unit]
Description=Career Academy local web service
After=network.target

[Service]
Type=simple
ExecStart=/opt/ca-yan-linux/start_server.sh
Restart=no

[Install]
WantedBy=multi-user.target
EOF
cat > /etc/systemd/system/legacy-web.service <<'EOF'
[Unit]
Description=Legacy local web service
After=network.target

[Service]
Type=simple
ExecStart=/opt/ca-yan-linux/legacy-start.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
chmod 0644 /opt/ca-yan-linux/start.sh
systemctl daemon-reload
systemctl enable --now legacy-web.service
systemctl enable ca-web.service >/dev/null
systemctl reset-failed ca-web.service >/dev/null 2>&1 || true
systemctl start ca-web.service >/dev/null 2>&1 || true
sleep 1
echo '[OK] Стенд возвращен в исходное диагностическое состояние'
