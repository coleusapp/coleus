FROM node:20-alpine3.18 AS node

COPY . /var/www

RUN \
    cd var/www && \
    npm ci && \
    npm run build && \
    rm -rf node_modules

FROM composer:2.5 AS composer

COPY composer.json composer.lock /var/www/

RUN \
    cd /var/www && \
    composer install --no-interaction --no-progress --no-scripts --no-dev --ignore-platform-reqs

FROM php:8.2-cli-alpine3.18

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN \
    apk update && \
    apk add --no-cache supervisor nginx && \
    install-php-extensions bcmath pdo_mysql openswoole

COPY /deploy/docker/nginx/default.conf /etc/nginx/http.d/default.conf
COPY /deploy/docker/nginx/nginx.conf /etc/nginx/nginx.conf

COPY /deploy/docker/supervisord.conf /etc/supervisor/supervisord.conf

COPY --from=composer --chown=www-data:www-data /var/www /var/www

COPY --from=node --chown=www-data:www-data /var/www /var/www

WORKDIR /var/www

RUN cp .env.example .env && chmod -R guo+w storage && chmod -R guo+w bootstrap/cache

EXPOSE 8000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
