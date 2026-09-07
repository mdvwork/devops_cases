# Финальный отчет

## Что создано
Mentor-репозиторий лабораторий Linux, Docker, CI и Monitoring с изоляцией student/mentor и безопасными setup/reset/verify/cleanup.

## Как запустить
```bash
make preflight
make setup-case1
```
Остальные starter-каталоги имеют собственные README и TASK.

## Как собрать student packages
```bash
make packages
unzip -l dist/yan-case-01-linux.zip
```
Сборщик включает только `student/` и проверяет отсутствие закрытых материалов и готовых решений.

## Как проверить каждый кейс
```bash
make verify-case1-broken
make verify-case1
make verify-case2-starter
make verify-case2 SOLUTION_DIR=/path/to/solution
make verify-case3
make verify-case4
make verify-case4-solved
```

## Что преподавателю нужно сделать вручную
Развернуть case 1 в реальной WSL2/systemd; проверить настоящие GitHub push/pull_request runs; внести CI-дефект после первого зеленого run; оценить объяснения, Git-историю, diagnostic report, runbook и Grafana dashboard; провести stop/recover при наблюдении студента.

## Что невозможно проверить автоматически
Без systemd PID 1 нельзя подтвердить units. Без Docker daemon/network нельзя подтвердить pulls, healthchecks и target. Локально нельзя подтвердить GitHub-hosted Actions или визуальное качество dashboard. Эти пункты нельзя считать успешными без реальной проверки.

## Известные ограничения
Case 1, 2 и 4 используют хостовый 8080 и запускаются по одному. Case 4 starter намеренно не наблюдает приложение. Credentials Grafana только учебные/локальные. Закрепленные версии требуют планового обновления.

## Чек-лист перед выдачей Яну
- [ ] Выполнен preflight; ограничения зафиксированы.
- [ ] Нужный starter проверен.
- [ ] `make packages` завершен успешно.
- [ ] Список ZIP просмотрен.
- [ ] Передается один ZIP без mentor-репозитория.
- [ ] Case 1 reset и broken-state подтверждены.
- [ ] В case 3 дефект еще не внесен.
- [ ] Для case 4 свободны 8080, 9090, 3000.
- [ ] Формат доказательств согласован.
