# Cloud Run with Eventarc for Events of Cloud Storage

This shows how to receive events from Cloud Storage in a Cloud Run using Eventarc.

## Description

### Cloud Audit Logs Policy

- [Go to the Cloud Audit Logs console](https://console.cloud.google.com/iam-admin/audit?_ga=2.112109824.522431159.1604272505-983599867.1599137884)
  - Enable Cloud Audit Logs `Admin Read`, `Data Read`, and `Data Write` Log Types in Cloud Storage

### Event HTTP headers
|HTTP Header|Description|
|-----------|-----------|
|ce-id|Unique ID of this message, assigned by the server when the event is generated.|
|ce-source|A string containing your project.|
|ce-specversion|The specification version used for this event.|
|ce-type|The CloudEvent type constant.|
|ce-subject|Metadata about the GCS bucket location.|

## Demo
### Deploy to Cloud Run
```
$ gcloud run deploy storage-event-controller \
      --image gcr.io/(gcloud config get-value project)/storage-event-controller \
      --allow-unauthenticated
```

## Features

- feature:1
- feature:2

## Requirement

## Usage

## Installation

## Licence

Released under the [MIT license](https://gist.githubusercontent.com/shinyay/56e54ee4c0e22db8211e05e70a63247e/raw/34c6fdd50d54aa8e23560c296424aeb61599aa71/LICENSE)

## Author

[shinyay](https://github.com/shinyay)
