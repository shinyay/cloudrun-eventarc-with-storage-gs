#!/usr/bin/env fish

function do_func
  set -l _project cloudrun-eventarc-with-storage-gs
  set -l _source eventarc-storage-getting-started
  set -l _app storage-event-receiver
  
  argparse -n do_func 'h/help' 'p/project=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "cloud-run.fish -p/--project <PROJECT_ID>"
    return
  end

  set -lq _flag_project
  or set -l _flag_project (gcloud config get-value project)

  gcloud run deploy $_app \
    --image gcr.io/$_flag_project/$_app \
    --allow-unauthenticated

end

do_func $argv
