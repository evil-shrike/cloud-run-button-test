#!/bin/bash
set -e
RED='\033[0;31m' # Red Color
CYAN='\033[0;36m' # Cyan
NC='\033[0m' # No Color

if [[ -f ./dashboard_url.txt ]]; then
  # found dashboard_url from previous run
  echo -e "It seems you have deployed the solution already."
  echo -e "If you haven't already, use this url for dashboard cloning:${CYAN}"
  cat ./dashboard_url.txt
  echo -e "${NC}"
  echo
  echo -n -e "${RED}Would you like to delete the current Cloud Run service (it's needed only for installation) (Y/N): ${NC}"
  read -r COMMIT_SUICIDE
  if [[ $COMMIT_SUICIDE = 'Y' || $COMMIT_SUICIDE = 'y' ]]; then
    REGION=$(curl -H Metadata-Flavor:Google http://metadata.google.internal/computeMetadata/v1/instance/region -s --fail)
    REGION=$(basename $REGION)
    echo "Detected region $REGION"
    gcloud run services delete $K_SERVICE --region $REGION
  else
    echo "Would you like to restart installation? (Y\/N)"
    read -r REPEAR_INSTALLATION
    if [[ -n $REPEAR_INSTALLATION ]]; then
      npm init gaarf-wf -- --answers=answers.json
    else
      echo "This is the end"
      exit
    fi
  fi
else
  npm init gaarf-wf -- --answers=answers.json
  # copy dashboard_url.txt to GCS
  if [[ -f ./dashboard_url.txt ]]; then
    PROJECT_ID=$(curl -H Metadata-Flavor:Google http://metadata.google.internal/computeMetadata/v1/project/project-id -s --fail)
    # TODO: hard-code of "gaarftest" :(
    gsutil -m cp -R ./dashboard_url.txt gs://$PROJECT_ID/gaarftest/
  fi
fi
