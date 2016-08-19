#!/bin/bash

BACKUP_DIR=/backups

function backup {
  mongodump -h db --out $BACKUP_DIR

  cd $BACKUP_DIR

  for D in `find . -mindepth 1 -type d`; do
    tar cf $D.tar $D
    rm -rf $D
  done
}

backup
