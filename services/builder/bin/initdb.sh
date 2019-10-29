#!/bin/bash

source /runtime/etc/configrc && \
cd / && \
wait-for-mysql.sh && \
git clone $GITHUB_DATABASE classicdb && \
git clone $GITHUB_CMANGOS mangos && \
git clone $GITHUB_API api && \
cp /runtime/etc/InstallFullDB.config /classicdb/ && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD < /api/sql/create_database.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD cmangosapi < /api/sql/create_tables.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD < /mangos/sql/create/db_create_mysql.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD classicmangos < /mangos/sql/base/mangos.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD classiccharacters < /mangos/sql/base/characters.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD classicrealmd < /mangos/sql/base/realmd.sql && \
cd /classicdb && \
./InstallFullDB.sh && \
echo Done.
