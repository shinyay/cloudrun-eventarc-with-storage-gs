#!/usr/bin/env fish

function do_func

gsutil mb -l us-central1 gs://events-quickstart-(gcloud config get-value project)
gsutil ls
end

do_func $argv
