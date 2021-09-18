################################
#                              #
#   Ubuntu - PHP 7.4 CLI+FPM   #
#                              #
################################

FROM ubuntu:bionic

MAINTAINER freddy1805 <frederik@roettgerkamp.com>

LABEL Vendor="freddy1805"
LABEL Description="PHP-FPM v7.4"
LABEL Version="1.0.0"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -yqq \
    && apt-get install -yqq \
	ca-certificates \
    git \
    gcc \
    make \
    wget \
    mc \
    curl \
    cron \
    zip \
    supervisor 

RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

## Install php7.4
RUN apt-get update -yqq && apt-get install -yqq php7.4

## Install php7.4 extension
RUN apt-get update -yqq \
    && apt-get install -yqq \
	php7.4-pgsql \
	php7.4-mysql \
	php7.4-sqlite \
	php7.4-sqlite3 \
	sqlite3 \
	libsqlite3-dev \
	php7.4-opcache \
	php7.4-common \
	php7.4-mbstring \
	php7.4-soap \
	php7.4-cli \
	php7.4-intl \
	php7.4-json \
	php7.4-xsl \
	php7.4-imap \
	php7.4-ldap \
	php7.4-curl \
	php7.4-gd  \
        php7.4-zip  \
	php7.4-dev \
        php7.4-fpm \
	php-igbinary \
	php7.4-redis \
	php-memcached \
	php-mongodb \
	php7.4-imagick \
	php7.4-bcmath \
        php-zmq \
        php7.4-apcu \
    && apt-get install pkg-config \
    && apt-get install -y -q --no-install-recommends \
       ssmtp

# Add default timezone
RUN echo "date.timezone=$TZ" > /etc/php/7.4/cli/conf.d/timezone.ini

# Download browscap.ini
RUN mkdir /var/lib/browscap \
    && wget http://browscap.org/stream?q=BrowsCapINI -O /var/lib/browscap/browscap.ini

## Install composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer -d=/var/www
USER root


# Copy our config files for php7.4 fpm and php7.4 cli
COPY conf/php.ini /etc/php/7.4/cli/php.ini
COPY conf/php-fpm.ini /etc/php/7.4/fpm/php.ini
COPY conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN apt-get install -y screen htop git

# Download and install wkhtmltopdf
RUN apt-get update && apt-get install xvfb libfontconfig wkhtmltopdf -y \
	&& rm -rf /var/lib/apt/lists/* \
        && rm -rf /tmp/* \
        && apt-get clean -yqq

## Create xvfb wrapper for wkhtmltopdf and create special sh script
RUN touch /usr/local/bin/wkhtmltopdf \
    && chmod a+x /usr/local/bin/wkhtmltopdf \
    && echo 'xvfb-run -a -s "-screen 0 640x480x16" wkhtmltopdf "$@"' > /usr/local/bin/wkhtmltopdf \
    && chmod a+x /usr/local/bin/wkhtmltopdf


RUN usermod -u 1000 www-data
RUN usermod -aG staff,users,www-data www-data
# Reconfigure system time
RUN  dpkg-reconfigure -f noninteractive tzdata

# Clear all packages and temp files
RUN	apt-get clean -yqq \
	&& apt-get purge php7.4-dev -yqq \
	&& apt-get purge git -yqq \
	&& apt-get purge gcc -yqq \
	&& apt-get purge make -yqq \
	&& apt-get purge wget -yqq \
	&& apt-get purge curl -yqq

RUN rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/* \
	&& apt-get clean -yqq

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

WORKDIR /var/www/symfony

EXPOSE 9000
