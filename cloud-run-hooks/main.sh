#!/bin/bash
set -e

install() {
  npm init gaarf-wf -- --answers=answers.json
}

NC='\033[0m' # No Color
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

if [[ -f ./dashboard_url.txt ]]; then
  # found dashboard_url from previous run
  echo -e "${White}It seems you have deployed the solution already.{$NC}"
  echo -e "If you haven't already, use this url for dashboard cloning:${Cyan}"
  cat ./dashboard_url.txt
  echo -e "${NC}"
  echo
  echo -n -e "${Red}Would you like to delete the current Cloud Run service (it's needed only for installation) (Y/N): ${NC}"
  read -r COMMIT_SUICIDE
  if [[ $COMMIT_SUICIDE = 'Y' || $COMMIT_SUICIDE = 'y' ]]; then
    REGION=$(curl -H Metadata-Flavor:Google http://metadata.google.internal/computeMetadata/v1/instance/region -s --fail)
    REGION=$(basename $REGION)
    echo "Detected region $REGION"
    gcloud run services delete $K_SERVICE --region $REGION
  else
    echo -n "Would you like to restart installation? (Y/N): "
    read -r REPEAR_INSTALLATION
    if [[ $REPEAR_INSTALLATION =~ ^[Yy]$ ]]; then
      install
    else
      echo "This is the end"
      bash
      exit
    fi
  fi
else
  install
fi
