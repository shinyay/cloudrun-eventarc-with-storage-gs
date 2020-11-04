#!/usr/bin/env fish

function do_func

  if test (count $argv) -eq 0
    echo "login-cloud.fish -u/--user <LOGIN_USER> -p/--project <PROJECT_ID>"
    return
  end

  argparse -n do_func 'h/help' 'u/user=' 'p/project=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "login-cloud.fish -u/--user <LOGIN_USER> -p/--project <PROJECT_ID>"
    return
  end

  set -lq _flag_user
  or set -l _flag_user ""
  set -lq _flag_project
  or set -l _flag_project ""

  gcloud components update --quiet
  gcloud components install beta
  gcloud auth login $_flag_user
  gcloud config set project $_flag_project
  gcloud config set run/region us-central1
  gcloud config set run/platform managed
  gcloud config set eventarc/location us-central1
  gcloud config list

  gcloud services enable run.googleapis.com
  gcloud services enable logging.googleapis.com
  gcloud services enable cloudbuild.googleapis.com
  gcloud services enable pubsub.googleapis.com
  gcloud services enable eventarc.googleapis.com
end

do_func $argv
