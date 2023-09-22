
# https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.compilationResults#CompilationResult
# https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowInvocations/create

Step#1: From Cloud Shell: cd to the current folder where the execution needs to happen
cd dataform/1_adhoc_git

Step#2: In this location, create a json in the format specified here(if not done already): https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.compilationResults#resource:-compilationresult
Example: input_compilationresult.json

Step#3: Execute the curl command for creating Compilation Results based on git commit(SHA or repo)
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     --data @./input_compilationresult.json \
     -X POST \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults

Step#4a:Verify the response of compilation result creation to be similar to this:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults/36f11718-0d44-4bae-a27a-d42bc1298de8",
  "gitCommitish": "sneha_ws",
  "codeCompilationConfig": {
    "defaultDatabase": "gcp-sandbox-3-393305",
    "defaultSchema": "df_ecom_bz",
    "assertionSchema": "df_ecom_assert",
    "vars": {
      "bronzeSchema": "df_ecom_bz",
      "silverSchema": "df_ecom_sl",
      "goldSchema": "df_ecom_gd"
    },
    "defaultLocation": "us-central1"
  },
  "dataformCoreVersion": "2.4.2",
  "resolvedGitCommitSha": "3319174946d8461ca67b6293e071577a6d31532d"
}

Step#4b:(Optional) Fetch the compilation result details:
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     -X GET \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults/a4e86a5f-3b36-4376-9729-aac76e56bab5

Response:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults/a4e86a5f-3b36-4376-9729-aac76e56bab5",
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
  "dataformCoreVersion": "2.4.2",
  "resolvedGitCommitSha": "78551eb35cec1fdc0d5d7488cb7f3bfc515401ca"
}

Step#5: In this location, create a json in the format specified here(if not done already): https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowInvocations#resource:-workflowinvocation
Example: input_workflowinvocation.json

Step#6: Execute the curl command for creating Workflow Invocation based on the compilation result received in step$4
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     --data @./input_workflowinvocation.json \
     -X POST \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowInvocations

Step#7:Verify the response of workflow invocation creation to be similar to this:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowInvocations/1694702680-2ab013b9-6d7b-482b-a4a3-e952380f0f12",
  "compilationResult": "projects/733328912700/locations/us-central1/repositories/dataform-learning-demo/compilationResults/22adc0ea-c18b-491e-9228-fa277e89c72c",
  "invocationConfig": {
    "includedTags": [
      "orders"
    ]
  },
  "state": "RUNNING",
  "invocationTiming": {
    "startTime": "2023-09-14T14:44:40.816105Z"
  }
}

Step#8: (Optional)View the status of workflow execution & verify the result:
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     -X GET \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowInvocations/1694786341-0e31865d-0497-45f2-8f51-26782da8ac4c
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

