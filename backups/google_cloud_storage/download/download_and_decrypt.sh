#/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[31m'
NC='\033[0m'

function quit_with_error {
  printf "\n${RED}Something went wrong. Exiting now.${NC}\n"
  exit 1
}

OUTPUT_DIRECTORY="/restored"

printf "\n${YELLOW}Provide hostname of the server you want to restore\n(default is $HOSTNAME)${NC}\n"
read USER_HOSTNAME

if [ ! -z "$USER_HOSTNAME" ]; then
  HOSTNAME=$USER_HOSTNAME
fi

printf "\n${YELLOW}Searching for $HOSTNAME backups in $BUCKET_NAME...${NC}\n"
BACKUPS=($(/root/google-cloud-sdk/bin/gsutil ls gs://$BUCKET_NAME | grep $HOSTNAME))
BACKUPS_AVAILABLE=${#BACKUPS[@]-1}
MAX_INDEX=$(expr $BACKUPS_AVAILABLE - 1)

# check if there any files in the given bucket
if [ "$BACKUPS_AVAILABLE" -eq 0 ]; then
  printf "${YELLOW}No backups available in bucket [$CHOSEN_BACKUP_NAME].${NC}\n"
  exit
fi

# list files from the bucket
printf "${YELLOW}Available backup files in bucket [$BUCKET_NAME]:${NC}\n"
for i in "${!BACKUPS[@]}"; do
  printf "[%s]  %s\n" "$i" "${BACKUPS[$i]}"
done

printf "${YELLOW}Please choose one of the backups listed above. [0-$MAX_INDEX]${NC}\n"
read backup_option

# get filename of the backup
CHOSEN_BACKUP_PATH=${BACKUPS[$backup_option]}
CHOSEN_BACKUP_NAME=`echo $CHOSEN_BACKUP_PATH | awk -F/ '{print $NF}'`

# downloading section
printf "\n${YELLOW}Downloading the $CHOSEN_BACKUP_NAME...${NC}\n"
/root/google-cloud-sdk/bin/gsutil cp $CHOSEN_BACKUP_PATH $OUTPUT_DIRECTORY/ || quit_with_error
printf "${GREEN}..done.${NC}\n"

# decrypting section
mkdir $OUTPUT_DIRECTORY/gpg_tmp_dir
printf "\n${YELLOW}Decrypting the $CHOSEN_BACKUP_NAME...${NC}\n"
gpg --output $OUTPUT_DIRECTORY/gpg_tmp_dir/gpg_tmp_file --decrypt $OUTPUT_DIRECTORY/$CHOSEN_BACKUP_NAME || quit_with_error
printf "${GREEN}..done.${NC}\n"

# unpacking section
printf "\n${YELLOW}Unpacking the $CHOSEN_BACKUP_NAME...${NC}\n"
7z x $OUTPUT_DIRECTORY/gpg_tmp_dir/gpg_tmp_file -o$OUTPUT_DIRECTORY/7z_tmp -y > /dev/null || quit_with_error
printf "${GREEN}..done.${NC}\n"

# cleaning
mv $OUTPUT_DIRECTORY/7z_tmp/* $OUTPUT_DIRECTORY || quit_with_error
rm -rf $OUTPUT_DIRECTORY/gpg_tmp_dir $OUTPUT_DIRECTORY/7z_tmp $OUTPUT_DIRECTORY/$CHOSEN_BACKUP_NAME || quit_with_error
printf "${GREEN}Backup $CHOSEN_BACKUP_NAME decrypted and unpacked.${NC}\n"
printf "\n${GREEN}The backup has been restored in $RESTORE_DIR${NC}\n"
