#!/bin/bash

RED='\033[31m'
NC='\033[0m'

if [ "$#" -ne 1 ]; then
  printf "Base name for the cloud backup is needed."
  exit 1
fi

function quit_with_error {
  printf "\n${RED}Something went wrong. Exiting now.${NC}\n"
  exit 1
}

CLOUD_BACKUP_BASE_NAME=$1

gpg --import /keys/public
/root/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file /auth/gcloud_api_key.json || quit_with_error
/encrypt_and_upload.sh $CLOUD_BACKUP_BASE_NAME /backup_archive.tar
/root/google-cloud-sdk/bin/gcloud auth revoke

