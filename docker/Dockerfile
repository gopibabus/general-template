FROM php:8.1-apache-buster

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS=0 \
    PHP_OPCACHE_MAX_ACCELERATED_FILES=8000 \
    PHP_OPCACHE_MEMORY_CONSUMPTION=128

RUN apt-get -yqq update \
    && apt-get -yqq install --no-install-recommends zip unzip \
        git \
        libicu-dev \
        libpq-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install mysqli pdo pdo_mysql pgsql pdo_pgsql intl \
    && pecl install xdebug redis \
    && docker-php-ext-enable xdebug redis \
    && a2enmod rewrite

COPY . /var/www/html
COPY docker/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY docker/config/php/conf.d/*.ini /usr/local/etc/php/conf.d/
COPY docker/start.sh /usr/local/bin/start
COPY docker/config/php/php.ini /usr/local/etc/php/php.ini

RUN chown -R www-data:www-data /var/www/html \
    && chmod +x /usr/local/bin/start

WORKDIR /var/www/html
RUN chmod o+rw writable/

CMD ["/usr/local/bin/start"]