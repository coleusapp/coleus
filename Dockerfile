FROM php:8.2-cli-alpine3.18 AS base

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN \
    apk update && \
    apk add --no-cache supervisor nginx && \
    install-php-extensions bcmath pdo_mysql openswoole pcntl && \
    rm /usr/local/bin/install-php-extensions

FROM node:20-alpine3.18 AS node

COPY . /var/www/html

RUN \
    cd var/www/html && \
    npm ci && \
    npm run build && \
    rm -rf node_modules

FROM composer:2.5 AS composer

COPY composer.json composer.lock /var/www/html/

ARG BUST_COMPOSER_CACHE

RUN \
    cd /var/www/html && \
    composer install --no-interaction --no-progress --no-scripts --no-dev --ignore-platform-reqs

FROM base

COPY --from=composer --chown=www-data:www-data /var/www/html /var/www/html

COPY --from=node --chown=www-data:www-data /var/www/html /var/www/html

WORKDIR /var/www/html

RUN \
    cp /var/www/html/deploy/docker/nginx/default.conf /etc/nginx/http.d/default.conf && \
    cp /var/www/html/deploy/docker/nginx/nginx.conf /etc/nginx/nginx.conf && \
    cp /var/www/html/deploy/docker/supervisord.conf /etc/supervisord.conf && \
    php artisan storage:link && \
    php artisan vendor:publish --all --no-interaction && \
    chown -R www-data:www-data /var/www/html && \
    find /var/www/html -type f -exec chmod 664 {} \; && \
    find /var/www/html -type d -exec chmod 775 {} \;

USER www-data

EXPOSE 8000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
