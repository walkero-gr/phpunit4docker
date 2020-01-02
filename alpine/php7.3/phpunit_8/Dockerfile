ARG PHP_VER

FROM php:${PHP_VER}-fpm-alpine

ARG PHPUNIT_VER
ARG XDEBUG_VER

MAINTAINER Georgios Sokianos <walkero@gmail.com>
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

RUN apk add --update --no-cache bash \
        autoconf \
        cmake \
        build-base \
        git \
        unzip \
        openssh; \
    docker-php-ext-install pdo_mysql; \
    pecl install redis; \
    docker-php-ext-enable pdo_mysql redis; \
    pecl install xdebug-${XDEBUG_VER}; \
    docker-php-ext-enable xdebug; \
    curl -fSL "https://getcomposer.org/installer" -o /tmp/composer-setup.php; \
    php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer; \
    rm -rf /tmp/composer-setup.php; \
    curl -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VER}.phar" -o /usr/local/bin/phpunit; \
    chmod +x /usr/local/bin/phpunit; \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*;

COPY configs/php.ini /usr/local/etc/php/conf.d/php.ini
CMD php-fpm -F -R