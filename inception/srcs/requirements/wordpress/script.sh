#!/bin/bash

# Wait for MariaDB to be ready
sleep 20

# Change directory to /var/www/html
cd /var/www/html

# Download WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Make WP-CLI executable
chmod +x wp-cli.phar

# Download WordPress core files
./wp-cli.phar core download --allow-root

# Create wp-config.php with environment variables
./wp-cli.phar config create --dbname=$MDB_NAME --dbuser=$MDB_USER --dbpass=$MDB_PASS --dbhost=$MDB_HOST --allow-root

# Change permissions of wp-config.php
chmod 777 wp-config.php

# Install WordPress with environment variables
./wp-cli.phar core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_SU_USR --admin_password=$WP_SU_PWD --admin_email=$WP_SU_EMAIL --allow-root

./wp-cli.phar user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --allow-root
./wp-cli.phar option update home $DOMAIN_NAME --allow-root
./wp-cli.phar option update siteurl  $DOMAIN_NAME --allow-root
chown -R www-data:www-data /var/www/html/wp-content/uploads
chmod -R 755 /var/www/html/wp-content/uploads
# WP_PATH="/var/www/html"

# # Change ownership to www-data (adjust if necessary for your web server user)
# sudo chown -R www-data:www-data $WP_PATH/wp-content/uploads

# # Set directory permissions to 755
# sudo find $WP_PATH/wp-content/uploads -type d -exec chmod 755 {} \;

# # Set file permissions to 644
# sudo find $WP_PATH/wp-content/uploads -type f -exec chmod 644 {} \;

# Start PHP-FPM
php-fpm8.2 -F
