ARG PHP_VER

FROM php:${PHP_VER}-fpm-alpine

ARG PHPUNIT_VER
ARG XDEBUG_VER

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

RUN apk add --update --no-cache bash \
        autoconf \
        cmake \
        build-base; \
    docker-php-ext-install mysqli pdo pdo_mysql; \
    pecl install redis && \
    docker-php-ext-enable mysqli pdo pdo_mysql redis; \
    pecl install xdebug-${XDEBUG_VER} && \
    docker-php-ext-enable xdebug; \
    curl -fsSkL "https://getcomposer.org/installer" -o /tmp/composer-setup.php  && \
    php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer && \
    rm -rf /tmp/composer-setup.php; \
    curl -fsSkL "https://phar.phpunit.de/phpunit-${PHPUNIT_VER}.phar" -o /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit; \
		apk del curl autoconf cmake build-base; \
		apk cache clean; \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*;

COPY ./configs/php.ini /usr/local/etc/php/conf.d/php.ini
CMD php-fpm -F -R
