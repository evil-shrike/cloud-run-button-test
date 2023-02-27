#!/bin/bash
set -e
set -x

#echo "K_SERVICE: $K_SERVICE"
#echo "GOOGLE_CLOUD_REGION: $GOOGLE_CLOUD_REGION"
#echo "GOOGLE_CLOUD_PROJECT: $GOOGLE_CLOUD_PROJECT"
#echo "APP_DIR: $APP_DIR"

gcloud config set project $GOOGLE_CLOUD_PROJECT

PROJECT_NUMBER=$(gcloud projects describe $GOOGLE_CLOUD_PROJECT --format="csv(projectNumber)" | tail -n 1)
SERVICE_ACCOUNT=$PROJECT_NUMBER-compute@developer.gserviceaccount.com

gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member=serviceAccount:$SERVICE_ACCOUNT --role=roles/resourcemanager.projectIamAdmin

gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable artifactregistry.googleapis.com
gcloud services enable iamcredentials.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable bigquery.googleapis.com
gcloud services enable cloudfunctions.googleapis.com
gcloud services enable googleads.googleapis.com
