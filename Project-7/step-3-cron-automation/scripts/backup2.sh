#!/bin/bash

DB_NAME="dvdrental"
DB_USER="postgres"
DB_HOST="localhost"
DB_PORT="5433"
PG_DUMP_PATH="/Applications/Postgres.app/Contents/Versions/latest/bin/pg_dump"

DEST="/Users/elifpolat/Desktop/BLM4522-Projects/Project-7/step-3-cron-automation/backups"
LOGFILE="/Users/elifpolat/Desktop/BLM4522-Projects/Project-7/step-3-cron-automation/logs/backup.log"

mkdir -p "$DEST"
mkdir -p "$(dirname "$LOGFILE")"

{
    echo "----------------------------"
    echo "Yedekleme Başlatıldı: $(date)"

    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    OUT_FILE="$DEST/dvdrental_$TIMESTAMP.dump"

    echo "Veritabanı: $DB_NAME, Port: $DB_PORT"

    $PG_DUMP_PATH -U $DB_USER -h $DB_HOST -p $DB_PORT -F c -d $DB_NAME -f "$OUT_FILE"

    if [ $? -eq 0 ]; then
        echo "BAŞARILI: $OUT_FILE"
    else
        echo "HATA: Yedekleme sırasında bir sorun oluştu!"
    fi

    echo "Bitiş Zamanı: $(date)"
} >> "$LOGFILE" 2>&1