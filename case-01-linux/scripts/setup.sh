#!/usr/bin/env bash
set -euo pipefail
[[ ${EUID} -eq 0 ]] || { echo '[FAIL] Запустите через sudo'; exit 1; }
command -v systemctl >/dev/null || { echo '[FAIL] systemctl не найден'; exit 1; }
[[ "$(ps -p 1 -o comm= | tr -d ' ')" == systemd ]] || { echo '[FAIL] systemd не является PID 1'; exit 1; }
install -d -m 0755 /opt/ca-yan-linux/www /opt/ca-yan-linux/legacy
cat > /opt/ca-yan-linux/start.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
cd /opt/ca-yan-linux/www
exec python3 -m http.server 8080 --bind 127.0.0.1
EOF
cat > /opt/ca-yan-linux/www/index.html <<'EOF'
<!doctype html>
<html><body><h1>Career Academy</h1><p>Linux diagnostic service</p><p>Service is working</p></body></html>
EOF
cat > /opt/ca-yan-linux/legacy/index.html <<'EOF'
<!doctype html><html><body><p>Legacy local service</p></body></html>
EOF
cat > /opt/ca-yan-linux/legacy-start.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
cd /opt/ca-yan-linux/legacy
exec python3 -m http.server 8080 --bind 127.0.0.1
EOF
chmod 0755 /opt/ca-yan-linux/legacy-start.sh
"$(dirname "$0")/reset.sh"
echo '[OK] Стенд case 1 установлен в исходном состоянии'
