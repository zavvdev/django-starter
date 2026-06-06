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

- Installing new packages with `pip` locally

- Using any local tooling like linters, formatters

Docker has its own isolated environment for packages.

Create `Makefile` and add next:
```Makefile
setup:
	python -m venv .venv
```

This will allow you to create venv using `make setup` command.

3. Run `pip install django django-environ` in order to install [Django
Framework](https://www.djangoproject.com/) and
[django-environ](https://django-environ.readthedocs.io/en/latest/) into the virtual environment.

4. Run `django-admin startproject config app` in order to setup your project. It will create `app/`
folder inside you project folder which will include `manage.py` file and `config/` folder.

- `manage.py` - Django's command-line utility for administrative tasks like running migrations or
  starting dev server.

- `config/` - Django's configurations

5. Create `requirements/` folder inside the project root with three files: `base.txt`, `dev.txt` and
`prod.txt`. These files are just lists of dependencies needed for your project.

`base.txt`:

```
Django>=6.0.6
django-environ>=0.13.0
psycopg2>=2.9.12
```

`psycopg2` - PostgreSQL database adapter

`dev.txt`:

```
-r base.txt
django-debug-toolbar
```

`django-debug-toolbar` - debugging panel that appears in your browser while developing.

`prod.txt`:

```
-r base.txt
gunicorn>=21.0
```

[gunicorn](https://gunicorn.org/) - is a production-ready Python web server. It acts as the bridge between your web application (such as Django, Flask, or FastAPI) and a reverse proxy server (like Nginx). While built-in development servers handle local testing, they crash under heavy traffic. Gunicorn provides the necessary stability, concurrency, and performance needed to run live web applications.
