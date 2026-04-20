#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
BACKUP_DEST="$SCRIPT_DIR/../backups"

echo "Yedekleme işlemi başlatıldı..."

/Applications/Postgres.app/Contents/Versions/latest/bin/pg_dump \
-U postgres \
-h localhost \
-p 5433 \
-F c \
-d dvdrental \
-f "$BACKUP_DEST/dvdrental_backup.dump"

if [ $? -eq 0 ]; then
    echo "Başarılı! Yedek şuraya kaydedildi: $BACKUP_DEST"
    ls -lh "$BACKUP_DEST/dvdrental_backup.dump"
else
    echo "Bir hata oluştu!"
fi