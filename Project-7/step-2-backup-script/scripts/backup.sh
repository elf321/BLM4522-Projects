#!/bin/bash

DATE=$(date +%Y%m%d_%H%M%S)

DB_NAME="dvdrental"
USER="postgres"
HOST="localhost"
PORT="5433"

BASE_DIR="$(pwd)"
BACKUP_DIR="$BASE_DIR/backups"
LOG_DIR="$BASE_DIR/logs"

mkdir -p $BACKUP_DIR
mkdir -p $LOG_DIR

BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$DATE.dump"
LOG_FILE="$LOG_DIR/backup_$DATE.log"

/Applications/Postgres.app/Contents/Versions/latest/bin/pg_dump \
-U $USER \
-h $HOST \
-p $PORT \
-F c \
-d $DB_NAME \
-f $BACKUP_FILE > $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
  echo "[OK] Backup başarılı: $BACKUP_FILE"
else
  echo "[ERROR] Backup başarısız! Log: $LOG_FILE"
fi