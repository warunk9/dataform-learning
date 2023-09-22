
# https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.releaseConfigs/create
# https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.compilationResults#CompilationResult
# https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowInvocations/create

Step#1: From Cloud Shell: cd to the current folder where the execution needs to happen
cd dataform/3_adhoc_release_configuration

Step#2: In this location, create a json in the format specified here(if not done already): https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.releaseConfigs/create
Example: input_release_config.json

Step#3: Execute the curl command for creating Release Configuration based on Git commit/tag/branch name
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     --data @./input_release_config.json \
     -X POST \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/releaseConfigs?releaseConfigId=dataform-learning-demo-rc1

Step#4a:Verify the response of release config creation to be similar to this:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/releaseConfigs/dataform-learning-demo-rc1",
  "gitCommitish": "development",
  "codeCompilationConfig": {
    "defaultDatabase": "gcp-sandbox-3-393305",
    "defaultSchema": "df_ecom_bz",
    "assertionSchema": "df_ecom_assert",
    "vars": {
      "silverSchema": "df_ecom_sl",
      "bronzeSchema": "df_ecom_bz",
      "goldSchema": "df_ecom_gd"
    },
    "defaultLocation": "us-central1"
  },
  "cronSchedule": "*/10 * * * *",
  "timeZone": "Asia/Calcutta"
}

Step#4b: Verify the release config to be available from the Dataform repository

Step#5: In this location, create a json in the format specified here(if not done already): https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.compilationResults#resource:-compilationresult
Example: input_release_compilationresult.json

Step#6: Execute the curl command for creating Compilation Results based on release config id created in earlier step
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     --data @./input_release_compilationresult.json \
     -X POST \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults

Step#7a:Verify the response of compilation result creation to be similar to this:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults/3ba00b3c-5ab3-4b60-8b85-520fd7e59ba2",
  "codeCompilationConfig": {
    "defaultDatabase": "gcp-sandbox-3-393305",
    "defaultSchema": "df_ecom_bz",
    "assertionSchema": "df_ecom_assert",
    "vars": {
      "silverSchema": "df_ecom_sl",
      "goldSchema": "df_ecom_gd",
      "bronzeSchema": "df_ecom_bz"
    },
    "defaultLocation": "us-central1"
  },
  "dataformCoreVersion": "2.4.2",
  "releaseConfig": "projects/733328912700/locations/us-central1/repositories/dataform-learning-demo/releaseConfigs/dataform-learning-demo-rc1",
  "resolvedGitCommitSha": "78551eb35cec1fdc0d5d7488cb7f3bfc515401ca"
}

Step#7b:(Optional) Fetch the compilation result details:
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     -X GET \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults/3ba00b3c-5ab3-4b60-8b85-520fd7e59ba2

Response:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults/3ba00b3c-5ab3-4b60-8b85-520fd7e59ba2",
  "codeCompilationConfig": {
    "defaultDatabase": "gcp-sandbox-3-393305",
    "defaultSchema": "df_ecom_bz",
    "assertionSchema": "df_ecom_assert",
    "vars": {
      "silverSchema": "df_ecom_sl",
      "goldSchema": "df_ecom_gd",
      "bronzeSchema": "df_ecom_bz"
    },
    "defaultLocation": "us-central1"
  },
  "dataformCoreVersion": "2.4.2",
  "releaseConfig": "projects/733328912700/locations/us-central1/repositories/dataform-learning-demo/releaseConfigs/dataform-learning-demo-rc1",
  "resolvedGitCommitSha": "78551eb35cec1fdc0d5d7488cb7f3bfc515401ca"
}

Step#8: In this location, create a json in the format specified here(if not done already): https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowInvocations#resource:-workflowinvocation
Example: input_release_workflowinvocation.json

Step#9: Execute the curl command for creating Workflow Invocation based on the compilation result received in previous step
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     --data @./input_release_workflowinvocation.json \
     -X POST \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowInvocations

Step#10:Verify the response of workflow invocation creation to be similar to this:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowInvocations/1694799110-ef4744b1-2e9b-40a6-8096-f597cb0b718d",
  "compilationResult": "projects/733328912700/locations/us-central1/repositories/dataform-learning-demo/compilationResults/3ba00b3c-5ab3-4b60-8b85-520fd7e59ba2",
  "invocationConfig": {
    "includedTags": [
      "orders"
    ],
    "transitiveDependenciesIncluded": true,
    "transitiveDependentsIncluded": true
  },
  "state": "RUNNING",
  "invocationTiming": {
    "startTime": "2023-09-15T17:31:50.317349Z"
  }
}



Step#11: (Optional)View the status of workflow execution & verify the result:
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     -X GET \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowInvocations/1694799110-ef4744b1-2e9b-40a6-8096-f597cb0b718d

Response Format will be similar to https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowInvocations#resource:-workflowinvocation:
  {
    "name": string,
  "invocationConfig": {
    object (InvocationConfig)
  },
  "state": enum (State),
  "invocationTiming": {
    object (Interval)
  },

  // Union field compilation_source can be only one of the following:
  "compilationResult": string,
  "workflowConfig": string
  // End of list of possible types for union field compilation_source.
}


