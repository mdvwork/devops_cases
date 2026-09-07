#!/usr/bin/env bash
set -u
fail=0
check(){ if command -v "$2" >/dev/null 2>&1; then echo "[OK] $1"; else echo "[FAIL] $1"; fail=1; fi; }
check Bash bash; check Python python3; check Git git; check curl curl; check Docker docker; check systemctl systemctl
if command -v docker >/dev/null && docker compose version >/dev/null 2>&1; then echo '[OK] Docker Compose'; else echo '[FAIL] Docker Compose'; fail=1; fi
if command -v docker >/dev/null && docker info >/dev/null 2>&1; then echo '[OK] Docker daemon'; else echo '[FAIL] Docker daemon недоступен'; fail=1; fi
if command -v systemctl >/dev/null && [[ "$(ps -p 1 -o comm= 2>/dev/null | tr -d ' ')" == systemd ]]; then echo '[OK] systemd активен'; else echo '[FAIL] systemd не PID 1'; echo '[INFO] В WSL задайте [boot] systemd=true в /etc/wsl.conf и выполните wsl --shutdown.'; fail=1; fi
exit "$fail"
