# Database backups scripts

Quay repository: [https://quay.io/repository/netguru/backups](https://quay.io/repository/netguru/backups)

## Building images

`docker build -t quay.io/netguru/backups:DATABASE-VERSION .` (from within directory with version, eg `backups/postgres/9.4`)

## Properly tag images

Tag should be in following format: `DATABASE-VERSION`, ex, if we're doing a backup script for postgres for version 9.4, the tag should be `postgres-9.4`
Aftar tagging / building, push it to quay: `docker push quay.io/netguru/backups:TAG`

## Usage of database backups

`docker run --rm -v DESTINATION_BACKUP_FOLDER:/backups --link DATABASE_CONTAINER:db quay.io/netguru/backups:TAG`

Example:

`docker run --rm -v /var/docker/volumes/postgresql94_backups:/backups --link postgres-9-4-5:db quay.io/netguru/backups:postgres-9.4`

Above command will create backup copies (sql format) of all databases from postgres-9-4-5 container to /var/docker/volumes/postgresql94_backups folder on host. They are not sent to any cloud service, it should be done in a seperate step.
