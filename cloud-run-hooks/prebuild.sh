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

if [[ $GOOGLE_ADS_CONFIG = "Y" || $GOOGLE_ADS_CONFIG = "y" ]]; then
  echo "using google-ads.yaml"
  # NOTE: the script is executed inside $APP_DIR folder (not where it's located) 
  if [[ ! -f ./google-ads.yaml && -f ./../google-ads.yaml ]]; then
    cp ./../google-ads.yaml ./google-ads.yaml
  fi
  if [[ ! -f ./google-ads.yaml ]]; then
    RED='\033[0;31m' # Red Color
    NC='\033[0m' # No Color
    echo -e "${RED}Could not found google-ads.yaml config file${NC}"
  fi

  sed -i -e "s|##*[[:space:]]*COPY google-ads.yaml \..*$|COPY google-ads.yaml \.|" ./Dockerfile
  # TODO: update 
  # "use_googleads_config": true,
fi
