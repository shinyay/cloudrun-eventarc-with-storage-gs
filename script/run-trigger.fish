#!/usr/bin/env fish

function do_func

echo "Hello World" > random.txt
gsutil cp random.txt gs://events-quickstart-(gcloud config get-value project)/random.txt
rm random.txt
end

do_func $argv
