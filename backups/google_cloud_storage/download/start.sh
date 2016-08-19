#!/bin/bash

gpg --import --allow-secret-key-import /keys/private
/root/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file /auth/gcloud_api_key.json
/download_and_decrypt.sh
/root/google-cloud-sdk/bin/gcloud auth revoke
