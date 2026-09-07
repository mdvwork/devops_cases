# Подготовка среды

## WSL2 и Ubuntu

Установите WSL2 и Ubuntu 22.04/24.04 средствами Windows. В Ubuntu проверьте PID 1:

```bash
ps -p 1 -o comm=
systemctl is-system-running
```

Если PID 1 не `systemd`, создайте `/etc/wsl.conf`:

```ini
[boot]
systemd=true
```

Затем из PowerShell выполните `wsl --shutdown` и снова откройте Ubuntu. Лабораторные скрипты сами эту настройку не меняют.

## Инструменты

Установите Python 3, Git и curl штатным пакетным менеджером Ubuntu. Установите Docker Desktop с WSL integration либо Docker Engine и Compose plugin по официальной документации. Проверьте:

```bash
./scripts/preflight.sh
docker run --rm hello-world
docker compose version
```

Case 1 требует `sudo`; остальные кейсы предполагают, что текущий пользователь уже имеет разрешение работать с Docker. Не добавляйте реальные секреты в файлы лаборатории.
