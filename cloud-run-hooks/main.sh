#!/bin/bash
set -e

if [[ -f ./dashboard_url.txt ]]; then
  # found dashboard_url from previous run
  echo -e "It seems you have deployed the solution already"
  echo "If you haven't already, use this url for dashboard cloding:"
  cat ./dashboard_url.txt
  echo -e "Would you like to delete the current Cloud Run service (it's needed only for installation)"
  read -r COMMIT_SUICIDE
  if [[ -n $COMMIT_SUICIDE ]]; then
    # TODO: kill the current service
    echo 'TODO: deleting '
    echo "K_SERVICE: $K_SERVICE"
    echo "GOOGLE_CLOUD_REGION: $GOOGLE_CLOUD_REGION"
    echo "GOOGLE_CLOUD_PROJECT: $GOOGLE_CLOUD_PROJECT"

    bash
    #gcloud run services delete $CR_NAME --region=$CR_REGION
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
fi
