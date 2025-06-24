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

To use this starter kit, you will generate your own repository from this template or Download it as a Zip.
If you download it as a Zip go to step 3.

### 1. Create Your Repository from this Template

Click the green **"Use this template"** button located at the top of the repository page on GitHub and choose **"Create a new repository"**. Follow the instructions to create a new repository under your own account.

### 2. Clone Your New Repository

Once your new repository is created, clone it to your local machine. Replace `<your-github-username>/<your-new-repo-name>.git` with the URL of the repository you just created.

```bash
git clone https://github.com/<your-github-username>/<your-new-repo-name>.git project-name
```

### 3. Enter the Project Directory

```bash
cd project-name
```

### 4. Configure the Environment and Ports

This project uses two separate environment files:
* `.env`: For Laravel application settings (database credentials, app key, etc.).
* `docker.env`: For Docker infrastructure settings (external ports).

First, create the Laravel environment file from the example:
```bash
cp .env.example .env
```

Next, create your local `docker.env` file. You can then edit it to change the default ports if needed.

```bash
cp docker.env.example docker.env
```

### 5. Start the Docker Containers

This command will build the image and start all services. On the first run, it will automatically install all dependencies, set up the application, and create a default admin user based on the `entrypoint.sh` script.

```bash
docker-compose up -d --build
```
*The first startup might take a few minutes. Subsequent startups will be instantaneous.*

### 6. Log In

The setup process automatically creates a default admin user. You can now access the admin panel and log in with the credentials `admin@localhost` and password `admin`.

## Accessing Services

* **Web Application**: `http://localhost:8087` (or the port you set in `docker.env`)
* **Admin Panel**: `http://localhost:8087/admin`
* **phpMyAdmin**: `http://localhost:8090`
* **MailHog**: `http://localhost:8025`

## Daily Usage

#### Managing Containers

```bash
# Start containers in the background
docker-compose up -d

# Stop containers
docker-compose down
```

#### Artisan Commands

To run any `artisan` command, prefix it with `docker-compose exec webserver`. An alias `pa` for `php artisan` is also available inside the container's shell.

```bash
docker-compose exec webserver php artisan list
# Or, after running `docker-compose exec webserver bash`:
# pa list
```

#### Running Tests

```bash
docker-compose exec webserver php artisan test
```

#### Code Quality

```bash
# Format code with Laravel Pint
docker-compose exec webserver ./vendor/bin/pint

# Analyze code with PHPMD
docker-compose exec webserver ./vendor/bin/phpmd app text phpmd.xml
```

#### Customizing Docker Ports

To temporarily run the project on different ports, you can specify environment variables on the command line. This overrides any values in `docker.env` for that session only.

```bash
# This command starts the webserver on port 9999 for this session
WEB_PORT=9999 docker-compose up -d
```