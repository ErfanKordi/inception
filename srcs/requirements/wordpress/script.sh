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

# Create a new user
./wp-cli.phar user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --allow-root

# Update WordPress options
./wp-cli.phar option update home $DOMAIN_NAME --allow-root
./wp-cli.phar option update siteurl $DOMAIN_NAME --allow-root

# Ensure proper ownership and permissions for uploads directory
chown -R www-data:www-data /var/www/html/wp-content/uploads
chmod -R 755 /var/www/html/wp-content/uploads

# Start PHP-FPM
php-fpm8.2 -F
