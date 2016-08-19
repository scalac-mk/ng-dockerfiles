#!/bin/bash

BACKUP_DIR=/backups
DBS=`echo 'show databases;' | mysql -h db | egrep -v "^(sys|Database|information_schema|performance_schema|mysql)"`

function backup {
  name=$1
  dir=$BACKUP_DIR/$name

  mkdir -p $dir

  filename=$name.sql

  mysqldump -h db --single-transaction $name > $dir/$filename
}


for i in $DBS; do
  echo "performing backup for $i..."
  backup $i
done
