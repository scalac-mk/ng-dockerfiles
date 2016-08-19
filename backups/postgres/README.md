# PostgreSQL dump scripts

Dump PostgreSQL databases using Docker images.

Quay repository: [https://quay.io/repository/netguru/backups](https://quay.io/repository/netguru/backups)

Available versions (and images tags) are:

* `9.3` (image tag: `postgres-9.3`)
* `9,4` (image tag: `postgres-9.4`)

## Example usage

`docker run --rm -v DESTINATION_BACKUP_FOLDER:/backups --link DATABASE_CONTAINER:db quay.io/netguru/backups:postgres-VERSION`

Where:
* `DESTINATION_BACKUP_FOLDER` is a folder where you want database to be held in host
* `DATABASE_CONTAINER` is the name of your postgres container
* `VERSION` is aforementioned suitable version

Above command will create a dump of every database (sql format) and put them in destination folder.
