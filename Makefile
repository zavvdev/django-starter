# If you had make command like:
# venv:
#	source .venv/bin/activate
# 
# you would get an error if you try to run it because it runs each command in a subshell, 
# so the activation only applies to that subshell and dies immediately. It doesn't affect
# your current terminal session. The activation must happen in your current shell.

# Prefix commands with the venv's Python directly
# so we can use them in the following commands in order to
# skip venv activation.
PYTHON = .venv/bin/python
PIP = .venv/bin/pip

# Creates virtual env folder
setup:
	python -m venv .venv

# Installs packages into virtual env
install:
	$(PIP) install -r requirements/dev.txt
