#!/bin/bash

/root/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file /auth/gcloud_api_key.json
/root/google-cloud-sdk/bin/gsutil ls gs://$BUCKET_NAME
/root/google-cloud-sdk/bin/gcloud auth revoke
