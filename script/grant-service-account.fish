#!/usr/bin/env fish

function do_func

  set -l PROJECT_NUMBER (gcloud projects list --filter=(gcloud config get-value project) --format='value(PROJECT_NUMBER)')

  gcloud projects add-iam-policy-binding (gcloud config get-value project) \
      --member=serviceAccount:service-$PROJECT_NUMBER@gcp-sa-pubsub.iam.gserviceaccount.com\
      --role=roles/iam.serviceAccountTokenCreator

  gcloud projects add-iam-policy-binding (gcloud config get-value project) \
      --member=serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com \
      --role=roles/eventarc.admin
  
end

do_func $argv
