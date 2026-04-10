#! /bin/bash
FULL="ShopDB-"$(date +"%Y-%m-%d_%H-%M-%S" | tr " " "-")
FULL_BACKUP=$FULL"-backup.sql"
DATA_BACKUP=$FULL"-data-backup.sql"

if [[ -n "$DB_USER" || -n "$DB_PASSWORD" ]]; then
    mysqldump -u $DB_USER -p$DB_PASSWORD "ShopDB" > $FULL_BACKUP

    mysqldump -u $DB_USER -p$DB_PASSWORD --no-create-info "ShopDB" > $DATA_BACKUP

    mysql -u $DB_USER -p$DB_PASSWORD "ShopDBReserve" < $FULL_BACKUP

    mysql -u $DB_USER -p$DB_PASSWORD "ShopDBDevelopment" < $DATA_BACKUP
else
    echo "Provide DB_PASSWORD and DB_USER"
fi
