FROM itdevgroup/php-fpm7.4

ARG PHP_VERSOION=7.4

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN apt update
RUN apt install -y screen htop

WORKDIR /var/www/symfony

CMD ["php-fpm7.4"]
