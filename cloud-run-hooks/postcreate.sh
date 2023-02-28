#!/bin/bash
set -e
set -x

PROJECT_ID=$(curl -H Metadata-Flavor:Google http://metadata.google.internal/computeMetadata/v1/project/project-id -s --fail)
gsutil -m cp -R ./Dockerfile gs://$PROJECT_ID/gaarftest/

echo 'Updating Cloud Run service $K_SERVICE'
# ttyd doesn't work on Gen2 environment, so we're updating it to Gen2, additionally increasing request timeout to the maximum allowed
gcloud run services update $K_SERVICE --execution-environment=gen2 --timeout=3600 --max-instances=1 --region=$GOOGLE_CLOUD_REGION
