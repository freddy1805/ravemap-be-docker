#!/bin/bash

echo "running post install scripts for php..";
cd /var/www/symfony

echo "CHECK COMPOSER DEPENDENCIES";
FILE=/var/www/symfony/vendor
if [ -d "$FILE" ]; then
    echo "$FILE exists. nothing to do!"
else 
    echo "$FILE does not exist. starting composer!"
    composer install
fi

php-fpm
