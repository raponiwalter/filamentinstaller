# Laravel & Filament Starter Kit

This is a project skeleton ("starter kit") designed to quickly start a new web application with **Laravel 12** and **Filament 3**.

The entire development environment is containerized with **Docker** and includes a full suite of tools to ensure code quality and a high-level developer experience.

## Main Features

* **Complete Docker Environment**: Ready to use with a single command.
    * **PHP 8.4**
    * **Apache** as the web server
    * **MariaDB** (MySQL) as the database
    * **phpMyAdmin** for database management
    * **MailHog** to catch and view emails during development
* **Modern Frameworks**:
    * **Laravel 12**
    * **Filament 3** for creating amazing admin panels
* **Code Quality**:
    * **Laravel Pint** pre-configured for automatic code formatting (PSR-12 standard + Laravel style).
    * **PHPMD** (PHP Mess Detector) with a solid set of rules for static code quality analysis.
    * **PHPUnit** already configured to run feature and unit tests on an in-memory database.
* **VS Code Integration**: Ready for automatic formatting on save via the Laravel Pint extension.

## Prerequisites

Before you begin, ensure you have the following installed on your system:
* [Docker](https://www.docker.com/get-started)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Installation and Setup

Follow these steps to get the project up and running.

### 1. Clone the Repository

Replace `project-name` with your desired name for the new application.

```bash
git clone https://github.com/raponiwalter/filamentinstaller.git project-name
```

```bash
#enter the project directory
cd project-name
````

### 3. Configure the Environment and Ports

This project uses two separate environment files:
* `.env`: For Laravel application settings (database credentials used by the app, app key, etc.).
* `docker.env`: For Docker infrastructure settings, primarily the external ports for the services.

First, create the Laravel environment file:
```bash
cp .env.example .env
````

**Method 1: Permanent Configuration (Recommended)**

This method is ideal for setting the ports you'll use consistently for this project.

A) Create your local `docker.env` file from the example:
```bash
cp docker.env.example docker.env
```

B) Open the docker.env file and change the value of WEB_PORT (and any others) to your desired port. For example, to run the webserver on port 8000:

```bash
# docker.env file
WEB_PORT=8000
DB_PORT=3380
# ... other ports
````

**Method 2: Temporary Override (On-the-fly)**

This is useful for quick tests or when you need to run the project on a different port for a single session without changing your configuration files.

Specify the port variable directly in the command line before `docker compose up`. This will override any value in `docker.env` for that specific command.

```bash
# This command starts the webserver on port 9999 for this session only
WEB_PORT=9999 docker compose up -d
```

### 4. Start the Docker Containers

This command will build the image and start all services. On the first run, it will automatically install all Composer and NPM dependencies, generate the app key, run migrations, and create a default admin user.
The default username is admin with password admin

```bash
docker compose up -d --build
````

## Accessing Services

* **Web Application**: `http://localhost:8087` (or the port you set in `docker.env` or through docker compose)
* **Admin Panel**: `http://localhost:8087/admin`
* **phpMyAdmin**: `http://localhost:8090`
* **MailHog**: `http://localhost:8025`

## Daily Usage

#### Managing Containers

```bash
# Start containers in the background
docker compose up -d

# Stop containers
docker compose down
```

#### Artisan Commands

To run any `artisan` command, prefix it with `docker compose exec webserver`:

```bash
docker compose exec webserver php artisan list
docker compose exec webserver php artisan make:model Product
```

#### Running Tests

```bash
docker compose exec webserver php artisan test
```

#### Code Quality

```bash
# Format code with Laravel Pint
docker compose exec webserver ./vendor/bin/pint

# Analyze code with PHPMD
docker compose exec webserver ./vendor/bin/phpmd app text phpmd.xml
```

