#!/bin/bash
echo ">> checking backend software..."
cd /var/www
FILE=/var/www/symfony/composer.json
if [ -f "$FILE" ]; then
    echo "$FILE exists. nothing to do!"
else 
    echo "$FILE does not exist. starting installation!"
    git clone https://github.com/freddy1805/ravemap-backend.git symfony/

    echo ">> running post install scripts for php..."
    cd /var/www/symfony

    echo ">> checking composer..."
    FILE=/var/www/symfony/vendor
    if [ -d "$FILE" ]; then
        echo "$FILE exists. nothing to do!"
    else 
        echo "$FILE does not exist. starting composer!"
        composer install

        echo ">> initialize db structure..."
        php bin/console doctrine:schema:create --force

        echo ">> create admin account and grant rights... (username: admin | password: test1234)"
        php bin/console fos:user:create admin info@ravemap.tk test1234
        php bin/console fos:user:promote admin ROLE_ADMIN
    fi
fi

cd /var/www/symfony
echo ">> starting websocket service..."
screen -d -m php bin/console gos:websocket:server

php-fpm
