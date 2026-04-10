#! /bin/bash
DATENOW=$(date | tr " " "-")
FULL="ShopDB-"${DATENOW:0:19}
FULL_BACKUP=$FULL"-backup.sql"
DATA_BACKUP=$FULL"-data-backup.sql"

mysqldump -u $DB_USER -p$DB_PASSWORD "ShopDB" > $FULL_BACKUP

mysqldump -u $DB_USER -p$DB_PASSWORD --no-create-info $DB_NAME > $DATA_BACKUP

mysql -u $DB_USER -p$DB_PASSWORD "ShopDBReserve" < $FULL_BACKUP

mysql -u $DB_USER -p$DB_PASSWORD "ShopDBDevelopment" < $DATA_BACKUP
