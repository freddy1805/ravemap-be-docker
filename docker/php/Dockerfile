FROM php:7.4-fpm

RUN apt update
RUN apt install -y zlib1g-dev g++ git screen htop libicu-dev zip libzip-dev libonig-dev libbz2-dev libmagickwand-dev libfreetype6 libfreetype6-dev
RUN apt install -y libpng*

RUN docker-php-ext-install intl opcache pdo pdo_mysql
RUN docker-php-ext-install gd
RUN docker-php-ext-install mbstring

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install bz2

RUN pecl install zip
RUN docker-php-ext-configure zip
RUN docker-php-ext-enable zip

RUN pecl install redis
RUN docker-php-ext-configure redis
RUN docker-php-ext-enable redis

RUN pecl install imagick
RUN docker-php-ext-configure imagick
RUN docker-php-ext-enable imagick

RUN pecl install igbinary
RUN docker-php-ext-configure igbinary
RUN docker-php-ext-enable igbinary

RUN pecl install apcu
RUN docker-php-ext-configure apcu
RUN docker-php-ext-enable apcu

RUN docker-php-ext-install iconv

WORKDIR /var/www/symfony

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

CMD ["php-fpm"]
