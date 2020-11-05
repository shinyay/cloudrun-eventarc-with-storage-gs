#!/usr/bin/env fish

function do_func
    set -l PROJECT_NUMBER (gcloud projects list --filter=(gcloud config get-value project) --format='value(PROJECT_NUMBER)')
    set -l _app storage-event-receiver

    gcloud beta eventarc triggers create storage-bucket-trigger \
        --destination-run-service=$_app \
        --destination-run-region=us-central1 \
        --matching-criteria="type=google.cloud.audit.log.v1.written" \
        --matching-criteria="serviceName=storage.googleapis.com" \
        --matching-criteria="methodName=storage.objects.create" \
        --service-account=$PROJECT_NUMBER-compute@developer.gserviceaccount.com

end

do_func $argv
