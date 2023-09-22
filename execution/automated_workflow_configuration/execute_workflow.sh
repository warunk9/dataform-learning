# https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowConfigs/create

Step#1: From Cloud Shell: cd to the current folder where the execution needs to happen
cd dataform/automated_workflow_configuration

Step#2: In this location, create a json in the format specified here(if not done already): https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowConfigs/create
Example: input_workflow_config.json

Step#3: Execute the curl command for creating Workflow Configuration based on a Release Configuration

curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     --data @./input_workflow_config.json \
     -X POST \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/
     workflowConfigs?workflowConfigId=dataform-learning-demo-rc1-wk1

Step#4a:Verify the response of workflow config creation to be similar to this:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowConfigs/dataform-learning-demo-rc1-wf1",
  "releaseConfig": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/releaseConfigs/dataform-learning-demo-rc1",
  "invocationConfig": {
    "includedTags": [
      "orders"
    ],
    "transitiveDependenciesIncluded": true,
    "transitiveDependentsIncluded": true
  },
  "cronSchedule": "0 0 1 * *",
  "timeZone": "Asia/Calcutta"
}

Step#4b: Verify the workflow config to be available from the Dataform repository

Step#5: (Optional)View the status of workflow creation & verify the result:
 curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     -X GET \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowConfigs/dataform-learning-demo-rc1-wf1


Response Format will be similar to https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowConfigs#WorkflowConfig:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowConfigs/dataform-learning-demo-rc1-wf1",
  "releaseConfig": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/releaseConfigs/dataform-learning-demo-rc1",
  "invocationConfig": {
    "includedTags": [
      "orders"
    ],
    "transitiveDependenciesIncluded": true,
    "transitiveDependentsIncluded": true
  },
  "cronSchedule": "0 0 1 * *",
  "timeZone": "Asia/Calcutta"
}
