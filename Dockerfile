FROM composer:2.8 AS composer

COPY composer.* /app/

RUN cd /app && \
    composer install --no-interaction --no-progress --no-scripts --no-dev --ignore-platform-reqs --optimize-autoloader --prefer-dist


FROM dunglas/frankenphp:1-php8.4-alpine

ENV SERVER_NAME=:8000
ARG USER=appuser

RUN \
    adduser ${USER}; \
    setcap -r /usr/local/bin/frankenphp; \
    chown -R ${USER}:${USER} /config/caddy /data/caddy

RUN install-php-extensions pdo_mysql && \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

USER ${USER}

COPY --chown=${USER}:${USER} --from=composer /app /app
COPY --chown=${USER}:${USER} . /app

EXPOSE 8000
