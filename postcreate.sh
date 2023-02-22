#!/bin/bash

set -e
set -x

echo "Setting Project ID: $GOOGLE_CLOUD_PROJECT"
gcloud config set project $GOOGLE_CLOUD_PROJECT

gcloud services enable cloudresourcemanager.googleapis.com

PROJECT_NUMBER=$(gcloud projects describe $GOOGLE_CLOUD_PROJECT --format="csv(projectNumber)" | tail -n 1)
SERVICE_ACCOUNT=$PROJECT_NUMBER-compute@developer.gserviceaccount.com

gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member=serviceAccount:$SERVICE_ACCOUNT --role=roles/resourcemanager.projectIamAdmin

gcloud run services update $K_SERVICE --execution-environment=gen2 --timeout=3600 --max-instances=1 --region=$GOOGLE_CLOUD_REGION
