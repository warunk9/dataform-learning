
# https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.compilationResults#CompilationResult
# https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowInvocations/create

Step#1: From Cloud Shell: cd to the current folder where the execution needs to happen
cd dataform/2_adhoc_workspace

Step#2: In this location, create a json in the format specified here(if not done already): https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.compilationResults#resource:-compilationresult
Example: input_wksp_compilationresult.json

Step#3: Execute the curl command for creating Compilation Results based on Dataform workspace name
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     --data @./input_wksp_compilationresult.json \
     -X POST \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults

Step#4a:Verify the response of compilation result creation to be similar to this:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults/61508cf7-5a74-41e5-8f8e-68bc5d62892f",
  "workspace": "projects/733328912700/locations/us-central1/repositories/dataform-learning-demo/workspaces/sneha_ws",
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
  "dataformCoreVersion": "2.4.2"
}

Step#4b:(Optional) Fetch the compilation result details:
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     -X GET \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults/61508cf7-5a74-41e5-8f8e-68bc5d62892f

Response:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/compilationResults/61508cf7-5a74-41e5-8f8e-68bc5d62892f",
  "workspace": "projects/733328912700/locations/us-central1/repositories/dataform-learning-demo/workspaces/sneha_ws",
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
  "dataformCoreVersion": "2.4.2"
}

Step#5: In this location, create a json in the format specified here(if not done already): https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories.workflowInvocations#resource:-workflowinvocation
Example: input_wksp_workflowinvocation.json

Step#6: Execute the curl command for creating Workflow Invocation based on the compilation result received in step$4
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     --data @./input_wksp_workflowinvocation.json \
     -X POST \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowInvocations

Step#7:Verify the response of workflow invocation creation to be similar to this:
{
  "name": "projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowInvocations/1694796425-0ac57156-c5ce-46d9-94d5-197b538c3208",
  "compilationResult": "projects/733328912700/locations/us-central1/repositories/dataform-learning-demo/compilationResults/61508cf7-5a74-41e5-8f8e-68bc5d62892f",
  "invocationConfig": {
    "includedTags": [
      "orders"
    ]
  },
  "state": "RUNNING",
  "invocationTiming": {
    "startTime": "2023-09-15T16:47:05.169510Z"
  }

Step#8: (Optional)View the status of workflow execution & verify the result:
curl --header "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
     --header 'Content-Type: application/json' \
     -X GET \
     https://dataform.googleapis.com/v1beta1/projects/gcp-sandbox-3-393305/locations/us-central1/repositories/dataform-learning-demo/workflowInvocations/1694796425-0ac57156-c5ce-46d9-94d5-197b538c3208

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

