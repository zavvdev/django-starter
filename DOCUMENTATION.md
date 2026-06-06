# Setup From Scratch

## Installation

1. In order to start Django project, you first need to have [Python](https://www.python.org/),
[Pip](https://pypi.org/project/pip/) and [Docker](https://www.docker.com/) installed in your system.
For setting up Python follow [this](./PYTHON_SETUP.md) steps.

2. Create a directory for your project: `mkdir django-starter && cd django-starter`.

3. Create a [virtual environment](https://docs.python.org/3/library/venv.html): `python -m venv .venv`.

4. Activate it: `source .venv/bin/activate`. You need to activate your virtual environment every
time when:

- Running `django-admin` or `manage.py` locally

- Installing new packages with `pip`

- Using any local tooling like linters, formatters

Docker has its own isolated environment for packages.

NOTE: Check [Makefile](./Makefile) in order to see how to automate venv activation process.

3. Run `pip install django django-environ` in order to install [Django
Framework](https://www.djangoproject.com/) and
[django-environ](https://django-environ.readthedocs.io/en/latest/) into the virtual environment.

4. Run `django-admin startproject config app` in order to setup your project. It will create `app/`
folder inside you project folder which will include `manage.py` file and `config/` folder.

- `manage.py` - Django's command-line utility for administrative tasks like running migrations or
  starting dev server.

- `config/` - Django's configurations
