#!/bin/bash
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

# Start PHP-FPM
php-fpm8.2 -F

# Function to wait for MariaDB to be ready
# wait_for_db() {
#     until mysql -h mariadb -u wpuser -ppassword -e "show databases;" > /dev/null 2>&1; do
#         echo "Waiting for mariadb to be ready..."
#         sleep 3
#     done
# }
# sleep 10
# cd /var/www/html
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# ./wp-cli.phar core download --allow-root
# ./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root
# chmod 777 wp-config.php
# ./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root

# php-fpm8.2 -F