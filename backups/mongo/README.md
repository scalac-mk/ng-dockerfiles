# MongoDB dump scripts

Dump MongoDB databases using Docker images. Available versions are:

* `2.4`
* `3.0`

## Example usage

`docker run --rm -v DESTINATION_BACKUP_FOLDER:/backups --link DATABASE_CONTAINER:db quay.io/netguru/backups:mongo-VERSION`

Where:
* `DESTINATION_BACKUP_FOLDER` is a folder where you want database to be held in host
* `DATABASE_CONTAINER` is the name of your mongodb container
* `VERSION` is aforementioned suitable version

Above command will create a dump of every database (bson format) and pack them in `.tar` format in destination folder.
