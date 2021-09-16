FROM ubuntu:18.04

ARG PHP_VERSOION=7.4


RUN apt-get update
RUN apt install -y zlib1g-dev g++ git screen htop libicu-dev zip libzip-dev libonig-dev libbz2-dev libmagickwand-dev
RUN apt install -y libfreetype6-dev libjpeg* libpng*
RUN apt install -y php${PHP_VERSOION}-fpm \
        php${PHP_VERSOION}-cli \
        php${PHP_VERSOION}-intl \
        php${PHP_VERSOION}-gd \
        php${PHP_VERSOION}-imagick \ 
        php${PHP_VERSOION}-json \
        php${PHP_VERSOION}-xml \
        php${PHP_VERSOION}-apcu \ 
        php${PHP_VERSOION}-mysqli \
        php${PHP_VERSOION}-zip \
        php${PHP_VERSOION}-opcache \
        php${PHP_VERSOION}-mbstring \
        php${PHP_VERSOION}-redis 

WORKDIR /var/www/symfony

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

CMD ["php-fpm7.4"]
