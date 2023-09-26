#!/bin/sh

SETUP='/init.sql'

# Check if database `mysql` has already been created
if [ ! -d "/var/lib/mysql/mysql" ]; then

    echo "Install mariadb for the first time"
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

fi

# Hydrate configuration template with env variables
echo "Setup initial file with env variables"
cat envsubst > ${SETUP}

echo "Start mysql daemon to receive arguments"
exec mysqld --user=mysql --datadir="/var/lib/mysql" --port=3306 --init-file ${SETUP} $@

# docker exec -it mariadb sh
