#!/bin/bash

# Check if the installation has already been done by looking for the .env file
if [ ! -f "/var/www/html/.env" ]; then
    echo "Laravel not found. Starting fresh installation..."

    # 1. Install the base Laravel project. This creates a standard composer.json.
    composer create-project laravel/laravel:^12.0 temp_laravel --prefer-dist
    mv temp_laravel/* temp_laravel/.* .
    rm -rf temp_laravel

    echo "Adding custom dependencies and tools..."

    # 2. Add the required packages using `composer require`.
    #    This modifies the composer.json created by Laravel.
    composer require filament/filament:^3.2 --no-interaction

    # 3. Add development dependencies.
    composer require --dev laravel/pint --no-interaction
    composer require --dev nunomaduro/collision --no-interaction
    composer require --dev fakerphp/faker --no-interaction
    composer require --dev mockery/mockery --no-interaction
    composer require --dev phpunit/phpunit --no-interaction

    # 4. Prepare the .env file and generate the application key.
    cp -f .env.setup .env
    
    if [ -f ".gitignore.example" ]; then
        cat .gitignore.example >> .gitignore
        echo ".gitignore updated with content from .gitignore.example."
    fi
    php artisan key:generate

    echo "Application key generated."

    # 5. Run the final setup commands.
    php artisan storage:link
    php artisan filament:install --panels
    php artisan migrate
    
    # Install NPM dependencies.
    npm install
    npm run build

    # Create the default admin user.
    echo "Creating default admin user..."
    php artisan make:filament-user --name=admin --email=admin@localhost --password=admin
    
    # Create the 'pa' alias for convenience.
    echo "alias pa='php artisan'" >> /root/.bashrc

    echo "Installation complete!"

else
    echo "Laravel already installed. Skipping installation."
fi

# Pass control to the Apache web server.
exec docker-php-entrypoint "$@"