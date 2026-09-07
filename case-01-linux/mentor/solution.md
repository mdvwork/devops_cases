# Эталон диагностики case 1

## Реальные причины

1. Unit `ca-web.service` ссылается на отсутствующий `/opt/ca-yan-linux/start_server.sh` вместо существующего `start.sh`.
2. После коррекции unit файл `start.sh` имеет режим `0644` и не исполняется.
3. После коррекции прав `legacy-web.service` уже слушает `127.0.0.1:8080`, поэтому новый HTTP server не может bind этот адрес.

## Ожидаемая последовательность

Студент начинает с `systemctl status ca-web.service`, затем читает связанные сообщения `journalctl -u ca-web.service`. Каждую ошибку сопоставляет с конкретным состоянием (`systemctl cat`, `ls -l`/`stat`, затем `ss -ltnp`, `ps`, `systemctl status legacy-web.service`), меняет только подтвержденную причину и повторяет запуск с чтением нового сообщения.

После правки unit необходимы `systemctl daemon-reload` и restart. Конфликт устраняется штатной остановкой и disable `legacy-web.service`, а не убийством случайного PID. Финальное доказательство включает active state, владельца listener и `curl`.

## Полезные команды преподавателю

```bash
systemctl status ca-web.service
journalctl -u ca-web.service --no-pager -n 50
systemctl cat ca-web.service
stat /opt/ca-yan-linux/start.sh
ss -ltnp 'sport = :8080'
systemctl disable --now legacy-web.service
systemctl daemon-reload
systemctl restart ca-web.service
curl http://127.0.0.1:8080
```

Студент должен понять последовательное проявление независимых причин, ценность журналов и точечной проверки, execute bit, lifecycle unit-файла и эксклюзивность TCP listener.
