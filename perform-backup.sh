#!/bin/bash

#dropbox incremental backup

# ==== CONFIG =======

KEEP_DAYS=14
SRC_DIR="PATH_TO_YOUR_FILES_TO_BACKUP"
DEST_DIR="/home/YOUR_USERNAME/Dropbox/backups/"
SNAPSHOT_FILE="/home/YOUR_USERNAME/backup.snar"
FULL_BACKUP_DAY=6 # (day of week to take the full backup - 1 = monday, 7 = sunday)

# ==== /CONFIG ======

DAY_OF_WEEK=`date +%u`
DATESTAMP=`date +%F-%H-%M-%S` # datestamp in format YYYY-MM-DD-HH-MM-SS

# TODO: create a full backup if theres no snar file.

if [ $DAY_OF_WEEK = $FULL_BACKUP_DAY ]; then
        echo "Taking Full Backup"
        rm -f SNAPSHOT_FILE
        FILENAME="backup-$DATESTAMP-full.tar.gz"
        tar -cvf $DEST_DIR/$FILENAME $SRC_DIR
else
        echo "Taking Incremental Backup"

        FILENAME="backup-$DATESTAMP-inc.tar.gz"
        tar -cvf $DEST_DIR/$FILENAME -g $SNAPSHOT_FILE $SRC_DIR
fi

# delete older archives
find $DEST_DIR -type f -name '*.tar.gz' -mtime +${KEEP_DAYS} -exec rm {} \;
