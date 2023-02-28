#!/bin/bash
set -e
#set -x

RED='\033[0;31m' # Red Color
CYAN='\033[0;36m' # Cyan
NC='\033[0m' # No Color

echo -n -e "${NC}Would you like to use a google-ads.yaml (Y) - if so, please upload one then enter 'Y', otherewise (N) you'll be asked to enter credentials later:${NC} "
read -r USE_GOOGLE_ADS_CONFIG
while [[ $USE_GOOGLE_ADS_CONFIG = "Y" || $USE_GOOGLE_ADS_CONFIG = "y" ]]; do 
  # NOTE: the script is executed inside $APP_DIR folder (not where it's located) 
  if [[ ! -f ./google-ads.yaml && -f ./../google-ads.yaml ]]; then
    cp ./../google-ads.yaml ./google-ads.yaml
  fi
  if [[ ! -f ./google-ads.yaml ]]; then    
    echo -e "${RED}Could not found google-ads.yaml config file${NC}"
    echo -n -e "${NC}Please upload google-ads.yaml and enter 'Y' or press Enter to skip: ${NC}"
    read -r USE_GOOGLE_ADS_CONFIG
  else
    break
  fi
done
if [[ $USE_GOOGLE_ADS_CONFIG = "Y" || $USE_GOOGLE_ADS_CONFIG = "y" ]]; then
  echo "Using google-ads.yaml"
  # update Dockerfile to copy google-ads.yaml:
  sed -i -e "s|##*[[:space:]]*COPY google-ads.yaml \..*$|COPY google-ads.yaml \.|" ./Dockerfile
  # update answers.json to use google-ads.yaml:
  sed -i -e "s|\"use_googleads_config\":[[:space:]]*false,|\"use_googleads_config\": true,|" ./answers.json
fi

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
