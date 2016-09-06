VENV_DIR=./venv
VENV_ACTIVATE_SCRIPT=$(VENV_DIR)/bin/activate

default: run

venv:
ifeq ("","$(wildcard "$(VENV_ACTIVATE_SCRIPT)")")
	@virtualenv $(VENV_DIR)
	@\
		source "$(VENV_ACTIVATE_SCRIPT)"; \
		pip install pip==8.1.1; \
		pip install pip-tools
endif

requirements.txt: venv requirements.in
	@source $(VENV_ACTIVATE_SCRIPT); pip-compile

deps: requirements.txt
	@echo "Dependencies compiled and up to date"

install: venv requirements.txt
	@echo "Synching dependencies..."
	@source $(VENV_ACTIVATE_SCRIPT); pip-sync

run: venv install
	@echo "Nothing to do"

.PHONY: default deps install run
