# Первый CI

Репозиторий содержит рабочее приложение и тесты. Перед настройкой CI проверьте их локально:

```bash
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
pytest -q
```

Создайте отдельный GitHub-репозиторий из содержимого этого каталога. Полное задание — в `TASK.md`.
