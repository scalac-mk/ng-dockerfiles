#!/bin/bash

BACKUP_DIR=/backups
DBS=`echo 'show databases;' | mysql -h db | egrep -v "^(sys|Database|information_schema|performance_schema|mysql)"`

function backup {
  name=$1
  dir=$BACKUP_DIR/$name

  mkdir -p $dir

  filename=$name.sql

  mysql -h db -e "STOP SLAVE;"
  mysql -h db -e "SHOW SLAVE STATUS\G" > $dir/$filename.slave-info
  mysqldump -h db --single-transaction --dump-slave=2 $name > $dir/$filename

  mysql -h db -e "START SLAVE;"
}


for i in $DBS; do
  echo "performing backup for $i..."
  backup $i
done
