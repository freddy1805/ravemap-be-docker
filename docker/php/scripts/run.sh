#!/bin/bash
echo "start downloading backend software..."
cd /var/www
git clone https://github.com/freddy1805/ravemap-backend.git > symfony

echo "running post install scripts for php..."
cd /var/www/symfony


echo "running composer..."
FILE=/var/www/symfony/vendor
if [ -d "$FILE" ]; then
    echo "$FILE exists. nothing to do!"
else 
    echo "$FILE does not exist. starting composer!"
    composer install
fi

echo "initialize db structure..."
php bin/console doctrine:schema:create --force


echo "create admin account and grant rights... (username: admin | password: test1234)"
php bin/console fos:user:create admin info@ravemap.tk test1234
php bin/console fos:user:promote admin ROLE_ADMIN

php-fpm
