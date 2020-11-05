#!/usr/bin/env fish

function do_func
  set -l _project cloudrun-eventarc-with-storage-gs
  set -l _source eventarc-storage-getting-started
  

  argparse -n do_func 'h/help' 'p/project=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "build.fish -p/--project <PROJECT_ID>"
    return
  end

  set -lq _flag_project
  or set -l _flag_project (gcloud config get-value project)

  gcloud alpha builds submit (pwd |awk -F "/$_project" '{print $1}')/$_project/$_source --pack image=gcr.io/$_flag_project/storage-event-receiver

end

do_func $argv
