#!/usr/bin/env fish

function do_func

gcloud beta eventarc triggers delete storage-bucket-trigger
gcloud beta eventarc triggers list
gcloud run delete storage-event-receiver
gcloud run services list

end

do_func $argv
