FROM php:7.4-fpm

RUN apt-get update
RUN apt install -y zlib1g-dev g++ git screen htop libicu-dev zip libzip-dev libonig-dev libbz2-dev libmagickwand-dev
RUN apt install -y libfreetype6-dev libjpeg62-turbo-dev libpng*

RUN docker-php-ext-install -j$(nproc) iconv pdo_mysql gd zip bcmath opcache mbstring bz2
RUN docker-php-ext-configure gd
RUN docker-php-ext-enable iconv pdo_mysql gd zip bcmath opcache mbstring bz2

RUN pecl install redis
RUN docker-php-ext-enable redis

RUN pecl install igbinary
RUN docker-php-ext-configure igbinary
RUN docker-php-ext-enable igbinary

RUN pecl install apcu
RUN docker-php-ext-configure apcu
RUN docker-php-ext-enable apcu

RUN pecl install imagick
RUN docker-php-ext-configure imagick
RUN docker-php-ext-enable imagick

WORKDIR /var/www/symfony

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

CMD ["php-fpm"]
