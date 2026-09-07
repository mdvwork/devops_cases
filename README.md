# Yan DevOps Labs — руководство преподавателя

Комплект из четырех последовательных диагностических лабораторий: **Linux → Docker → CI → Monitoring**. Репозиторий преподавателя содержит закрытые материалы в `mentor/`; студенту передаются только ZIP-архивы из `dist/`.

## 1. Зависимости

Целевая среда: Windows 10/11, WSL2 с Ubuntu 22.04/24.04 и включенным systemd, Bash, Python 3, Git, curl, Docker Engine/Desktop с Compose plugin. Для case 1 нужны права `sudo`. GitHub нужен для запуска case 3.

```bash
make preflight
```

Подробная подготовка: [`docs/environment-setup.md`](docs/environment-setup.md).

## 2. Подготовка и сброс case 1

Команды меняют только `/opt/ca-yan-linux`, `/etc/systemd/system/ca-web.service` и `/etc/systemd/system/legacy-web.service`.

```bash
make setup-case1
make verify-case1-broken
# после работы студента
make verify-case1
# вернуть исходное состояние
make reset-case1
# окончательно удалить стенд
make cleanup-case1
```

Цели case 1 явно сообщают, что потребуют `sudo`.

## 3. Сборка student packages

```bash
make packages
```

Получившиеся файлы: `dist/yan-case-01-linux.zip` … `dist/yan-case-04-monitoring.zip`. Скрипт заново создает `dist/`, включает только содержимое соответствующего `student/` и проверяет список файлов на закрытые материалы и готовые решения.

## 4. Проверка кейсов

```bash
make verify-case2-starter
make verify-case2 SOLUTION_DIR=/path/to/student/case-02-docker
make verify-case3
make verify-case4
make verify-case4-solved
make verify-all
```

`verify-case4-solved` запускают только после того, как студент добавил target приложения. `verify-all` проверяет starter-состояния и не изменяет case 1. Docker-проверки всегда завершаются `docker compose down` для своего project name.

## 5. Что отправлять Яну

Передавайте **только один нужный архив из `dist/`**. Не отправляйте весь mentor-репозиторий, каталоги `mentor/`, `FINAL_REPORT.md`, это руководство или другие архивы. Подробный процесс описан в [`docs/student-delivery.md`](docs/student-delivery.md).

## 6. Восстановление после занятия

```bash
make reset-case1       # подготовить case 1 повторно
make cleanup-case1     # удалить case 1
# В student-копии case 2 или 4:
docker compose -p yan-lab-case02 down --remove-orphans
docker compose -p yan-lab-case04 down --remove-orphans
```

Для case 3 используйте `case-03-ci/mentor/scripts/remove-defect.sh`. Эти команды не очищают чужие контейнеры, images или volumes. Дополнительные сценарии: [`docs/troubleshooting.md`](docs/troubleshooting.md).
