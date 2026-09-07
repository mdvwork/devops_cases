# Устранение проблем

## systemd недоступен

Выполните `ps -p 1 -o comm=`. Если это не systemd, следуйте `docs/environment-setup.md`. Не запускайте case 1 до исправления среды.

## Docker daemon недоступен

Проверьте `docker info`. Запустите Docker Desktop и убедитесь, что WSL integration включена. Скрипты не пытаются менять daemon.

## Порт занят

Case 1 намеренно использует 8080. Case 2 и case 4 тоже публикуют 8080, поэтому запускайте лаборатории по одной. Определите владельца порта до остановки процесса; не применяйте `kill -9` наугад.

## Compose-проверка прервана

Из каталога соответствующего student-проекта выполните:

```bash
docker compose -p yan-lab-case02 down --remove-orphans
docker compose -p yan-lab-case04 down --remove-orphans
```

Команды затрагивают только ресурсы с указанным project name.
