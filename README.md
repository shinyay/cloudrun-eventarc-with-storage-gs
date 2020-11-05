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

### Create Eventarc Trigger
```
$ gcloud beta eventarc triggers create events-quickstart-trigger \
      --destination-run-service=storage-event-controller \
      --destination-run-region=us-central1 \
      --matching-criteria="type=google.cloud.audit.log.v1.written" \
      --matching-criteria="serviceName=storage.googleapis.com" \
      --matching-criteria="methodName=storage.objects.create" \
      --service-account="(gcloud projects list --filter=(gcloud config get-value project) --format='value(PROJECT_NUMBER)')"-compute@developer.gserviceaccount.com
```

```
$ gcloud beta eventarc triggers list --location=us-central1
```

## Features

### Eventarc Trigger
#### Type List
```
$ gcloud beta eventarc attributes types list

NAME                                           DESCRIPTION
google.cloud.audit.log.v1.written              Cloud Audit Log written
google.cloud.pubsub.topic.v1.messagePublished  Cloud Pub/Sub message published
```

#### Service Name List
```
$ gcloud beta eventarc attributes service-names list --type google.cloud.audit.log.v1.written

SERVICE_NAME                                DISPLAY_NAME
accessapproval.googleapis.com               Access Approval
apigee.googleapis.com                       Apigee
apigeeconnect.googleapis.com                Apigee Connect
apikeys.googleapis.com                      API Keys
appengine.googleapis.com                    App Engine
automl.googleapis.com                       Cloud AutoML
bigquery.googleapis.com                     BigQuery
bigquerybiengine.googleapis.com             BigQuery BI Engine
bigqueryconnection.googleapis.com           BigQuery Connection
bigqueryreservation.googleapis.com          BigQuery Reservation
bigtable.googleapis.com                     Cloud Bigtable
bigtableadmin.googleapis.com                Cloud Bigtable Admin
bigtabletableadmin.googleapis.com
binaryauthorization.googleapis.com          Binary Authorization
clientauthconfig.googleapis.com             Identity-Aware Proxy (IAP)
cloudasset.googleapis.com                   Cloud Asset
cloudbilling.googleapis.com                 Cloud Billing
cloudbuild.googleapis.com                   Cloud Build
clouddebugger.googleapis.com                Cloud Debugger
clouderrorreporting.googleapis.com          Cloud Error Reporting
cloudfunctions.googleapis.com               Cloud Functions
cloudiot.googleapis.com                     Cloud IoT
cloudkms.googleapis.com                     Cloud Key Management Service (KMS)
cloudprofiler.googleapis.com                Cloud Profiler
cloudresourcemanager.googleapis.com         Cloud Resource Manager
cloudscheduler.googleapis.com               Cloud Scheduler
cloudsearch.googleapis.com                  Cloud Search
cloudsql.googleapis.com                     Cloud SQL
cloudtasks.googleapis.com                   Cloud Tasks
cloudtrace.googleapis.com                   Cloud Trace
composer.googleapis.com                     Cloud Composer
compute.googleapis.com                      Compute Engine
containeranalysis.googleapis.com            Container Analysis
customerusagedataprocessing.googleapis.com  Transparency and Control Center Audit Logging
datacatalog.googleapis.com                  Cloud Data Catalog
dataflow.googleapis.com                     Cloud Dataflow
datafusion.googleapis.com                   Cloud Data Fusion
datahub.googleapis.com
datalabeling.googleapis.com                 Cloud AI Data Labelling
dataproc.googleapis.com                     Cloud Dataproc
datastore.googleapis.com                    Cloud Datastore
deploymentmanager.googleapis.com            Cloud Deployment Manager
dialogflow.googleapis.com                   Cloud Dialogflow
dlp.googleapis.com                          Cloud Data Loss Prevention
dns.googleapis.com                          Cloud DNS
domains.googleapis.com                      Google Domains
eventarc.googleapis.com
file.googleapis.com                         Cloud Filestore
firebase.googleapis.com                     Cloud Firebase
firebasedatabase.googleapis.com             Firebase Realtime Database
firestore.googleapis.com                    Cloud Firestore
gameservices.googleapis.com                 Cloud Gaming
gkeconnect.googleapis.com                   Google Kubernetes Engine (GKE)
gkehub.googleapis.com
healthcare.googleapis.com                   Cloud Healthcare
iam.googleapis.com                          Cloud IAM
iamcredentials.googleapis.com               Cloud IAM Service Account Credentials
iap.googleapis.com                          Identity-Aware Proxy (IAP)
identitytoolkit.googleapis.com              Identity Toolkit
industrialadaptivecontrols.googleapis.com
lifesciences.googleapis.com                 Cloud Life Sciences
logging.googleapis.com                      Cloud Logging
managedidentities.googleapis.com            Cloud Managed Microsoft Active Directory
memcache.googleapis.com                     Cloud Memcache
meshca.googleapis.com                       Mesh certificate authority
metastore.googleapis.com                    Dataproc Metastore
ml.googleapis.com                           Cloud Machine Learning Engine
monitoring.googleapis.com                   Cloud Monitoring
networkmanagement.googleapis.com            Network Management
notebooks.googleapis.com                    AI Platform Notebooks
osconfig.googleapis.com                     Cloud OS Config
oslogin.googleapis.com                      Cloud OS Login
pubsub.googleapis.com                       Cloud Pub/Sub
recaptchaenterprise.googleapis.com          reCAPTCHA Enterprise
recommendationengine.googleapis.com         Recommendations AI
redis.googleapis.com                        Cloud Memorystore for Redis
remotebuildexecution.googleapis.com         Remote Build Execution
run.googleapis.com                          Cloud Run
secretmanager.googleapis.com                Secret Manager
securitycenter.googleapis.com
serviceconsumermanagement.googleapis.com    Service Consumer Management
servicedirectory.googleapis.com             Service Directory
servicemanagement.googleapis.com            Service Management
serviceusage.googleapis.com                 Service Usage
sourcerepo.googleapis.com                   Cloud Source Repositories
spanner.googleapis.com                      Cloud Spanner
ssh-serialport.googleapis.com               GCE Serial Port
storage.googleapis.com                      Cloud Storage
sts.googleapis.com                          Storage Transfer Service
tpu.googleapis.com                          Cloud TPU
translate.googleapis.com                    Cloud Translation
videointelligence.googleapis.com            Cloud Video Intelligence
vision.googleapis.com                       Cloud Vision
vpcaccess.googleapis.com                    Serverless VPC Access
websecurityscanner.googleapis.com           Web Security Scanner
workflowexecutions.googleapis.com           Workflow Executions
workflows.googleapis.com                    Workflows
```

#### Method Name List
```
$ gcloud beta eventarc attributes method-names list --type google.cloud.audit.log.v1.written --service-name storage.googleapis.com

METHOD_NAME
storage.buckets.create
storage.buckets.delete
storage.buckets.get
storage.buckets.list
storage.buckets.update
storage.getIamPermissions
storage.hmacKeys.create
storage.hmacKeys.delete
storage.hmacKeys.get
storage.hmacKeys.list
storage.hmacKeys.update
storage.objects.create
storage.objects.delete
storage.objects.get
storage.objects.list
storage.objects.update
storage.projects.getOrCreateServiceAccount
storage.setIamPermissions
```

## Requirement

## Usage

## Installation

## Licence

Released under the [MIT license](https://gist.githubusercontent.com/shinyay/56e54ee4c0e22db8211e05e70a63247e/raw/34c6fdd50d54aa8e23560c296424aeb61599aa71/LICENSE)

## Author

[shinyay](https://github.com/shinyay)
