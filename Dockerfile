FROM php:8.4-apache

# --- 1. ENVIRONMENT SETTINGS ---

WORKDIR /var/www/html
ENV DEBIAN_FRONTEND=noninteractive


# --- 2. SYSTEM DEPENDENCIES AND PHP EXTENSIONS ---

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    # Existing dependencies
    git \
    curl \
    unzip \
    libzip-dev \
    libonig-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libicu-dev \
    && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && \
    # Clean up apt cache
    rm -rf /var/lib/apt/lists/*

# Install PHP extensions.
RUN docker-php-ext-install \
    pdo pdo_mysql \
    zip \
    gd \
    exif \
    bcmath \
    intl


# --- 3. INSTALLATION OF COMPOSER ---

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


# --- 4. CONFIGURATION FOR DYNAMIC INSTALLER ---
COPY .env.setup /env.setup


# --- 5. APACHE SERVER CONFIGURATION ---

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite


# --- 6. ENTRYPOINT ---

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80
CMD ["apache2-foreground"]