# Google Cloud Storage scripts
There are three docker images for controlling backups in Google Cloud Storage:

1. `quay.io/netguru/backups:upload`
2. `quay.io/netguru/backups:restore`
3. `quay.io/netguru/backups:list`

## Upload image
The upload image is used for zipping, encrypting and pushing DB backups from the host to Google Cloud Storage.

Example usage:

`docker run -t -v /root/keys:/keys -v /root/auth:/auth -v /tmp/backup.tar:/backup_archive.tar -e "BUCKET_NAME=$BUCKET" -e "GPG_USER=$GPG_USER" quay.io/netguru/backups:upload /start.sh $CLOUD_BACKUP_BASE_NAME`

Where
* `$BUCKET` is the name of the Google Cloud Storage bucket backup needs to go
* `$GPG_USER` is an email of a virtual user used for encrypting/decrypting, unique for each host
* `$CLOUD_BACKUP_BASE_NAME` is a basic name of the backup uploaded to GCloud; this name is going to have `.7z.gpg` postfix attached to it after an upload
* `/keys` should be mounted as volume and contain one file named `public`, which contains public gpg key for encrypting
* `/auth` should be mounted as volume and contain a file named `gcloud_api_key.json` (https://cloud.google.com/vision/docs/auth-template/cloud-api-auth)


## Restore image
The restore image is used for downloading and decrypting the backup file from Google Cloud Storage. The script is inteactive and will guide you through the process. Remember - you have to set proper GPG keys before trying to download and decrypt the backup file.

Example usage:

`docker run -it -v /root/keys:/keys -v $RESTORE_DIR/:/restored -v /root/auth:/auth -e "BUCKET_NAME=$BUCKET" quay.io/netguru/backups:restore`

Where
* `$RESTORE_DIR` is a path to the directory where the backup will be restored (this image will restore backup inside container to `/restored` folder, that's why it's most convenient to mount a directory as volume that maps to the host's folder)
* `$BUCKET` is the name of the bucket on Google Cloud Storage backup should be restored from
* `/keys` folder should be mounted as volume and should contain one file named `private`, which contains private gpg key for decrypting
* `/auth` should be mounted as volume and contain a file named `gcloud_api_key.json` (https://cloud.google.com/vision/docs/auth-template/cloud-api-auth)

## List image
The list image is used for listing the content of the `$BUCKET` bucket.

Example usage:

`docker run -t -v /root/auth:/auth -e "BUCKET_NAME=$BUCKET" quay.io/netguru/backups:list`

Where
* `$BUCKET` is the name of the bucket in Google Cloud Storage
* `/auth` should be mounted as volume and contain a file named `gcloud_api_key.json` (https://cloud.google.com/vision/docs/auth-template/cloud-api-auth)

