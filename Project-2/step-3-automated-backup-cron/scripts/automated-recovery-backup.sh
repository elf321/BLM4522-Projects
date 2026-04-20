#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
BACKUP_DIR="$SCRIPT_DIR/../backups"
LOG_FILE="$SCRIPT_DIR/../logs/recovery_backup.log"
WAL_DIR="/Users/elifpolat/Desktop/BLM4522-Projects/Project-2/step-2-wal-configuration/wal_archive"

mkdir -p "$BACKUP_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
echo "--- Yedekleme Başladı: $TIMESTAMP ---" >> "$LOG_FILE"

/Applications/Postgres.app/Contents/Versions/latest/bin/pg_dump -U postgres -h localhost -p 5433 -F c -d dvdrental -f "$BACKUP_DIR/dvdrental_full_$TIMESTAMP.dump"

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Full Backup başarıyla alındı: dvdrental_full_$TIMESTAMP.dump" >> "$LOG_FILE"
else
    echo "[ERROR] Full Backup ALINAMADI!" >> "$LOG_FILE"
fi

WAL_COUNT=$(ls -1 "$WAL_DIR" | wc -l)
echo "[INFO] Arşivlenmiş Güncel WAL Dosya Sayısı: $WAL_COUNT" >> "$LOG_FILE"

echo "--- Yedekleme Bitti: $(date) ---" >> "$LOG_FILE"
echo "--------------------------------------" >> "$LOG_FILE"