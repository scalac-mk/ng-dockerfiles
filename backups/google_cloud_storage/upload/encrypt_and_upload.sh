#/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[31m'
NC='\033[0m'

function quit_with_error {
  printf "\n${RED}Something went wrong. Exiting now.${NC}\n"
  exit 1
}

if [ "$#" -ne 2 ]; then
  printf "\n${RED}Usage of script: ./[name] [base backup name in cloud] [local backup path]${NC}\n"
  exit 1
fi

CLOUD_BACKUP_BASE_NAME=$1
LOCAL_BACKUP_NAME=$2

COMPRESSED_CLOUD_BACKUP_FILE_NAME="$CLOUD_BACKUP_BASE_NAME.7z"
GPG_COMPRESSED_CLOUD_BACKUP_FILE_NAME="$COMPRESSED_CLOUD_BACKUP_FILE_NAME.gpg"

#compressing section
printf "${YELLOW}Compressing the file...${NC}\n"
7z a $COMPRESSED_CLOUD_BACKUP_FILE_NAME $LOCAL_BACKUP_NAME || quit_with_error
printf "${GREEN}..done.${NC}\n"

#encrypting section
printf "\n${YELLOW}Encrypting the file...${NC}\n"
ENCRYPT="gpg --encrypt --output $GPG_COMPRESSED_CLOUD_BACKUP_FILE_NAME --always-trust --recipient '$GPG_USER' $COMPRESSED_CLOUD_BACKUP_FILE_NAME"
eval $ENCRYPT || quit_with_error
printf "${GREEN}..done.${NC}\n"

#uploading section
printf "\n${YELLOW}Uploading the file...${NC}\n"
/root/google-cloud-sdk/bin/gsutil cp $GPG_COMPRESSED_CLOUD_BACKUP_FILE_NAME gs://$BUCKET_NAME || quit_with_error
printf "${GREEN}..done.${NC}\n"

# cleaning
rm $COMPRESSED_CLOUD_BACKUP_FILE_NAME $GPG_COMPRESSED_CLOUD_BACKUP_FILE_NAME || quit_with_error
printf "${GREEN}Backup $GPG_COMPRESSED_CLOUD_BACKUP_FILE_NAME encrypted and uploaded.${NC}\n"
