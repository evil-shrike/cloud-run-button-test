#!/bin/bash
set -e
set -x

#echo "Setting Project ID: $GOOGLE_CLOUD_PROJECT"
#gcloud config set project $GOOGLE_CLOUD_PROJECT
#gcloud services enable cloudresourcemanager.googleapis.com

gcloud run services update $K_SERVICE --execution-environment=gen2 --timeout=3600 --max-instances=1 --region=$GOOGLE_CLOUD_REGION
