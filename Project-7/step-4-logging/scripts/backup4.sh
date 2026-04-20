#!/bin/bash

DB_NAME="dvdrental"
DB_USER="postgres"
DB_HOST="localhost"
DB_PORT="5433"
PG_DUMP_PATH="/Applications/Postgres.app/Contents/Versions/latest/bin/pg_dump"

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
DEST="$SCRIPT_DIR/../backups"
LOGFILE="$SCRIPT_DIR/../logs/backup.log"

mkdir -p "$DEST"
mkdir -p "$(dirname "$LOGFILE")"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
OUT_FILE="$DEST/dvdrental_step4_$TIMESTAMP.dump"

echo "--------------------------------------------" >> "$LOGFILE"
echo "=== Yedekleme İşlemi Başladı: $TIMESTAMP ===" >> "$LOGFILE"

$PG_DUMP_PATH -U $DB_USER -h $DB_HOST -p $DB_PORT -F c -d $DB_NAME -f "$OUT_FILE"

if [ $? -eq 0 ]; then
    FILE_SIZE=$(du -h "$OUT_FILE" | cut -f1)
    
    echo "[SUCCESS] Status: Başarılı" >> "$LOGFILE"
    echo "[INFO] Veritabanı: $DB_NAME" >> "$LOGFILE"
    echo "[INFO] Dosya: $(basename $OUT_FILE)" >> "$LOGFILE"
    echo "[INFO] Boyut: $FILE_SIZE" >> "$LOGFILE"
    
    osascript -e 'display notification "'$DB_NAME' yedeği '$FILE_SIZE' boyutuyla alındı." with title "DB Admin Raporu" subtitle "İşlem Başarılı"'
else
    echo "[ERROR] Status: BAŞARISIZ!" >> "$LOGFILE"
    
    osascript -e 'display notification "HATA: Veritabanı yedeği alınamadı!" with title "DB Admin ALARM" subtitle "Kritik Hata"'
    say "Warning: Database backup failed"
fi

echo "=== İşlem Bitti: $(date +"%Y-%m-%d %H:%M:%S") ===" >> "$LOGFILE"
echo "--------------------------------------------" >> "$LOGFILE"
echo "" >> "$LOGFILE"