# MySQL dump scripts

Dump MySQL databases using Docker images.

Quay repository: [https://quay.io/repository/netguru/backups](https://quay.io/repository/netguru/backups)

Available versions (and images tags) are:

* `5.7` (image tag: `mysql-5.7`)
* `5.7-slave` (image tag: `mysql-5.7-slave`)

## Example usage

`docker run --rm -v DESTINATION_BACKUP_FOLDER:/backups --link DATABASE_CONTAINER:db quay.io/netguru/backups:mysql-VERSION`

Where:
* `DESTINATION_BACKUP_FOLDER` is a folder where you want database to be held in host
* `DATABASE_CONTAINER` is the name of your mongodb container
* `VERSION` is aforementioned suitable version

Above command will create a dump of every database (sql format) and pack them in `.tar` format in destination folder.

`slave` version will stop slave, dump database along with slave information (`SHOW SLAVE STATUS`) and start slave back again

_note: scripts are using --single-transaction option_
