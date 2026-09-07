# Мини-мониторинг сервиса

Stack содержит приложение, Prometheus и Grafana. В исходном состоянии Prometheus наблюдает только себя; dashboard приложения отсутствует.

```bash
docker compose up --build -d
```

Адреса: приложение `http://127.0.0.1:8080`, Prometheus `http://127.0.0.1:9090`, Grafana `http://127.0.0.1:3000`. Учебные credentials — в `.env.example`. Полное задание — в `TASK.md`.
