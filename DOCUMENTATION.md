# Setup From Scratch

## Installation

### 1. Install Python and Pip

In order to start Django project, you first need to have [Python](https://www.python.org/),
[Pip](https://pypi.org/project/pip/) and [Docker](https://www.docker.com/) installed in your system.
For setting up Python follow [this](./PYTHON_SETUP.md) steps.

### 2. Create an empty directory for the project

Create a directory for your project: `mkdir django-starter && cd django-starter`.

### 3. Create a virtual environment

Create a [virtual environment](https://docs.python.org/3/library/venv.html): `python -m venv .venv`.

### 4. Activate virtual environment

Activate it: `source .venv/bin/activate`. You need to activate your virtual environment every
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

### 5. Install Django

Run `pip install django django-environ` in order to install [Django
Framework](https://www.djangoproject.com/) and
[django-environ](https://django-environ.readthedocs.io/en/latest/) into the virtual environment.

### 6. Create a project

Run `django-admin startproject config src` in order to setup your project. It will create `src/`
folder inside you project folder which will include `manage.py` file and `config/` folder.

- `manage.py` - Django's command-line utility for administrative tasks like running migrations or
  starting dev server.

- `config/` - Django's configurations

The syntax is:

```
django-admin startproject <project_name> <destination_folder>
```

### 7. Create requirements lists

Create `requirements/` folder inside the project root with three files: `base.txt`, `dev.txt` and
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

### 8. Create env variables

**`.env.dev`**
```ini
DEBUG=True
SECRET_KEY=your-dev-secret-key-here
ALLOWED_HOSTS=localhost,127.0.0.1

POSTGRES_DB=mydb_dev
POSTGRES_USER=myuser
POSTGRES_PASSWORD=mypasswd
POSTGRES_HOST=db
POSTGRES_PORT=5432

DJANGO_SETTINGS_MODULE=config.settings.dev

DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_EMAIL=admin@example.com
DJANGO_SUPERUSER_PASSWORD=admin
```

**`.env.prod`**
```ini
DEBUG=False
SECRET_KEY=your-strong-production-secret-key-here
ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com

POSTGRES_DB=mydb_prod
POSTGRES_USER=myuser
POSTGRES_PASSWORD=mypasswd
POSTGRES_HOST=db
POSTGRES_PORT=5432

DJANGO_SETTINGS_MODULE=config.settings.prod
```

Variables in .env files for Postgres should match names of the variables that Postgres
container expects.

Variables for superuser will be automatically used when our `web` service starts.

**`.gitignore`** — never commit secrets:
```
.env.dev
.env.prod
```

### 9. Django settings

Create:

`src/config/settings/base.py`,
`src/config/settings/dev.py`,
`src/config/settings/prod.py`,

Also create: `src/myproject/settings/__init__.py` which should be empty.

Check contents of these files in this project.

Update this line in manage.py, asgi.py and wsgi.py:

```python
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
```

to: 

```python
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings.dev')
```

since we split out config by envs.

The `setdefault` in those files is just a fallback — it only applies if `DJANGO_SETTINGS_MODULE` is not already set in the environment. Since we're setting it in your our .env files, Docker will inject it into the container and the `setdefault` line will be ignored.

### 10. Configure Docker

Create `Dockerfile`, `docker-compose.dev.yml` and `docker-compose.prod.yml`. Check the contents of
these files in this repository.

### 11. Add basic Nginx setup

Why using Nginx with Gunicorn?
Nginx has some web server functionality (e.g., serving static pages; SSL handling) that gunicorn does not, whereas gunicorn implements WSGI (which nginx does not).

Make sure you have this line in your `src/config/settings/base.py`:

```python
STATIC_ROOT = BASE_DIR / 'staticfiles'
```

It's the local folder where `collectstatic` dumps everything for Web Server to serve.

Create `nginx/nginx.conf` file. Check the contents of this file in this repo.

### 12. Update Makefile

Check `Makefile` in this repo.
