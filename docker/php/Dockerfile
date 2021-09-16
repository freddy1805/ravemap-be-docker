FROM php:7.4-fpm

ARG PHP_IM_VERSION=3.4.4
ARG PHP_VERSION=7.4

RUN apt update
RUN apt-get install -y gnupg2 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C && \
    echo -n 'deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main' > /etc/apt/sources.list.d/ondrej-ubuntu-php-bionic.list && apt-get update && \
    curl -L https://github.com/Imagick/imagick/archive/${PHP_IM_VERSION}.tar.gz -o imagick-${PHP_IM_VERSION}.tar.gz && \
    tar -zxvf imagick-${PHP_IM_VERSION}.tar.gz && rm imagick-${PHP_IM_VERSION}.tar.gz && \
    cd imagick-${PHP_IM_VERSION} && phpize && ./configure && make && \
    mkdir /phpmods && cp -r modules /phpmods && \
    cd .. && \
    rm -rf imagick-${PHP_IM_VERSION} && \
    ldconfig /usr/local/lib


RUN apt install -y zlib1g-dev g++ git screen htop libicu-dev zip libzip-dev libonig-dev libbz2-dev libmagickwand-dev
RUN apt install -y libfreetype6-dev libjpeg62-turbo-dev libpng*

RUN docker-php-ext-install -j$(nproc) iconv pdo_mysql gd zip bcmath opcache mbstring bz2
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-enable iconv pdo_mysql gd zip bcmath opcache mbstring bz2

RUN pecl install redis
RUN docker-php-ext-configure redis
RUN docker-php-ext-enable redis

RUN pecl install igbinary
RUN docker-php-ext-configure igbinary
RUN docker-php-ext-enable igbinary

RUN pecl install apcu
RUN docker-php-ext-configure apcu
RUN docker-php-ext-enable apcu

## CLEANUP
RUN apt-get remove --autoremove --purge -y gnupg2 php${PHP_VERSION}-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/symfony

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

CMD ["php-fpm"]
