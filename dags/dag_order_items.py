import datetime,json
from airflow import models
from airflow.utils.dates import days_ago
from airflow.models import Variable
from google.cloud.dataform_v1beta1 import WorkflowInvocation
from airflow.providers.google.cloud.operators.dataform import (
    DataformCancelWorkflowInvocationOperator,
    DataformCreateCompilationResultOperator,
    DataformCreateRepositoryOperator,
    DataformCreateWorkflowInvocationOperator,
    DataformCreateWorkspaceOperator,
    DataformDeleteRepositoryOperator,
    DataformDeleteWorkspaceOperator,
    DataformGetCompilationResultOperator,
    DataformGetWorkflowInvocationOperator,
    DataformInstallNpmPackagesOperator,
    DataformMakeDirectoryOperator,
    DataformRemoveDirectoryOperator,
    DataformRemoveFileOperator,
    DataformWriteFileOperator,
)
from airflow.providers.google.cloud.sensors.dataform import DataformWorkflowInvocationStateSensor
from airflow.providers.google.cloud.utils.dataform import make_initialization_workspace_flow

PROJECT_ID="gcp-sandbox-3-393305"
REGION="us-central1"
REPOSITORY_ID="dataform-learning-demo"
WORKSPACE_ID="paras-ws"

default_args = {
    'start_date': datetime.datetime.strptime("2020-01-01 00:00:00", "%Y-%m-%d %H:%M:%S"),
    'retries' : 0,
    "concurrency" : 1,
}

with models.DAG(
        "dataform_run_order_items",
        default_args = default_args, 
        schedule_interval = None,
        tags = ['tag:fact'],
        catchup = False,
        render_template_as_native_obj=True

) as dag:

    create_compilation_result = DataformCreateCompilationResultOperator(
        task_id="create-compilation-result",
        project_id=PROJECT_ID,
        region=REGION,
        repository_id=REPOSITORY_ID,
        compilation_result={
            "git_commitish": "main",
            "workspace": (
                f"projects/{PROJECT_ID}/locations/{REGION}/repositories/{REPOSITORY_ID}/"
                f"workspaces/{WORKSPACE_ID}"
            ),
        },
    )

    create_workflow_invocation = DataformCreateWorkflowInvocationOperator(
        task_id="create-workflow-invocation",
        project_id=PROJECT_ID,
        region=REGION,
        repository_id=REPOSITORY_ID,
        workflow_invocation={
            "compilation_result": "{{ task_instance.xcom_pull('create-compilation-result')['name'] }}",
            "invocation_config": { "included_tags": ["order_items"], "transitive_dependencies_included": True }
        },
    )

    create_compilation_result >> create_workflow_invocation