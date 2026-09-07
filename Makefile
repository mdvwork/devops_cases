SHELL := /usr/bin/env bash
SOLUTION_DIR ?= case-02-docker/student

.PHONY: preflight setup-case1 reset-case1 verify-case1 verify-case1-broken cleanup-case1 verify-case2 verify-case2-starter verify-case3 verify-case4 verify-case4-solved packages verify-all
preflight:
	./scripts/preflight.sh
setup-case1:
	@echo "[INFO] Требуются права sudo для установки systemd units"
	sudo ./case-01-linux/scripts/setup.sh
reset-case1:
	@echo "[INFO] Требуются права sudo для изменения systemd units"
	sudo ./case-01-linux/scripts/reset.sh
verify-case1:
	sudo ./case-01-linux/scripts/verify-solved.sh
verify-case1-broken:
	sudo ./case-01-linux/scripts/verify-broken.sh
cleanup-case1:
	@echo "[INFO] Требуются права sudo для удаления файлов лаборатории"
	sudo ./case-01-linux/scripts/cleanup.sh
verify-case2-starter:
	./case-02-docker/scripts/verify-starter.sh
verify-case2:
	./case-02-docker/scripts/verify-solution.sh "$(SOLUTION_DIR)"
verify-case3:
	./case-03-ci/mentor/scripts/verify-clean.sh
verify-case4:
	./case-04-monitoring/scripts/verify-stack.sh
verify-case4-solved:
	./case-04-monitoring/mentor/scripts/verify-target.sh
packages:
	./scripts/build-student-packages.sh
verify-all:
	./scripts/verify-all.sh
