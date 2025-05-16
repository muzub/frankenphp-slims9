FROM dunglas/frankenphp:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype-dev \
    libicu-dev \
    libonig-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions required by SLiMS
RUN docker-php-ext-install \
    pdo_mysql \
    mysqli \
    zip \
    gd \
    intl \
    mbstring \
    xml

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Download and extract SLiMS 9 Bulian
RUN curl -L https://github.com/slims/slims9_bulian/archive/refs/heads/master.zip -o slims.zip \
    && unzip slims.zip \
    && rm slims.zip \
    && mv slims9_bulian-master/* . \
    && mv slims9_bulian-master/.* . 2>/dev/null || true \
    && rmdir slims9_bulian-master

# Configure FrankenPHP for SLiMS
COPY Caddyfile /etc/caddy/Caddyfile

# Set proper permissions
RUN chown -R www-data:www-data /app

EXPOSE 80 443