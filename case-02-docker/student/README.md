# Контейнеризация веб-сервиса

Рабочее FastAPI-приложение находится в `app/`. Локальный запуск из этого каталога:

```bash
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --host 127.0.0.1 --port 8000
```

Требования к сдаче приведены в `TASK.md`.
