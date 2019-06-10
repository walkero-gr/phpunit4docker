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
        openssh; \
    docker-php-ext-install \
        pdo_mysql \
        pdo_pgsql; \
    rm -rf /var/cache/apk/*; \
    pecl install xdebug-2.6.1; \
    docker-php-ext-enable xdebug; \
    curl -fSL "https://getcomposer.org/installer" -o /tmp/composer-setup.php; \
    php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer; \
    rm -rf /tmp/composer-setup.php; \
    curl -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VER}.phar" -o /usr/local/bin/phpunit; \
    chmod +x /usr/local/bin/phpunit

COPY configs/php.ini /usr/local/etc/php/conf.d/php.ini
CMD php-fpm -F -R