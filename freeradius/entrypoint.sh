#!/bin/bash

envsubst < /etc/freeradius/clients.conf.template > /etc/freeradius/clients.conf
envsubst '${MYSQL_USER} ${MYSQL_PASSWORD} ${MYSQL_DATABASE}' < /etc/freeradius/mods-available/sql.template > /etc/freeradius/mods-available/sql

ln -sf /etc/freeradius/mods-available/sql /etc/freeradius/mods-enabled/sql

exec /wait_for_db.sh mysql:3306 -- freeradius -X