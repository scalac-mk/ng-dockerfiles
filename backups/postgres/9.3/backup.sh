#!/bin/bash

BACKUP_DIR=/backups
DBS=`psql -U postgres -h db -tAc "SELECT pg_database.datname FROM pg_database;" | egrep -v "template.|postgres"`

function backup {
  name=$1
  dir=$BACKUP_DIR/$name

  mkdir -p $dir

  filename=$name.sql

  pg_dump -U postgres -h db -d $name > $dir/$filename
}


for i in $DBS; do
  echo "performing backup for $i..."
  backup $i
done
