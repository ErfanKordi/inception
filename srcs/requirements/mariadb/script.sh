#!/bin/bash

# Define the SQL commands with placeholders
sql_commands="CREATE DATABASE IF NOT EXISTS ${MDB_NAME};
CREATE USER IF NOT EXISTS '${MDB_USER}'@'%' IDENTIFIED BY '${MDB_PASS}';
GRANT ALL PRIVILEGES ON *.* TO '${MDB_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

echo "$sql_commands"
# Substitute the environment variables and write to /etc/mysql/init.sql
echo "$sql_commands"  >> /etc/mysql/init.sql

# Initialize the MySQL data directory
mysql_install_db --user=mysql --ldata=/var/lib/mysql

# Start MySQL service
mysqld_safe --datadir=/var/lib/mysql --socket=/var/run/mysqld/mysqld.sock --pid-file=/var/run/mysqld/mysqld.pid
