ARG PHP_VER

FROM php:${PHP_VER}-fpm-alpine

ARG PHPUNIT_VER

MAINTAINER Georgios Sokianos <walkero@gmail.com>
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

RUN apk add --update --no-cache bash \
    autoconf \
    cmake \
    build-base \
    git \
    unzip \
    openssh \
    && rm -rf /var/cache/apk/*

RUN pecl install xdebug-2.6.1; \
    docker-php-ext-enable xdebug;
    
RUN curl -fSL "https://getcomposer.org/installer" -o /tmp/composer-setup.php;
RUN php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer && \
    rm -rf /tmp/composer-setup.php

RUN curl -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VER}.phar" -o /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit

CMD php-fpm -F -R