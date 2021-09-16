FROM php:7.4-fpm

RUN apt update
RUN apt install -y zlib1g-dev g++ git screen htop libicu-dev zip libmcrypt-dev libzip-dev libonig-dev libbz2-dev libmagickwand-dev libfreetype6 libfreetype6-dev
RUN apt install -y libpng*

RUN docker-php-ext-install -j$(nproc) iconv mcrypt pdo_mysql gd zip curl bcmath opcache mbstring bz2
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-enable iconv mcrypt pdo_mysql gd zip curl bcmath opcache mbstring bz2

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

WORKDIR /var/www/symfony

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

CMD ["php-fpm"]
