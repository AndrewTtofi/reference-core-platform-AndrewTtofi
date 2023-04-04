# GitHub Actions bootstrap (GCP)

## Bootstrap

To bootstrap GitHub Actions, edit `config.yaml` and then a GCP project owner needs to run `terragrunt apply`.
The output values should then be configured in GitHub Actions.

### Inputs

The target GCP project and region need to be specifed, as well as the GitHub organization and repository that would be granted GitHub Actions access via OIDC:

|input|description|example|
|--|--|--|
|`gcp_project_id`|GCP project id|`my-sandbox-4b1d`|
|`gcp_region` |GCP region|`europe-west2`|
|`github_sa`|GitHub Actions service account name|`github-actions-sa`|
|`github_user`|GitHub user or organization|`coreeng`|
|`github_repo`|GitHub repository|`reference-core-platform-my-fork`|

### Outputs

The service account and workload identity provider outputs will need to be set to the corresponding GitHub Actions repository variables:
 
|output|variable|sample|
|--|--|--|
|`github_actions_service_account`|`GCP_SERVICE_ACCOUNT`|`github-actions-sa@my-sandbox-4b1d.iam.gserviceaccount.com`|
|`github_actions_workload_identity_provider`|`GCP_WORKLOAD_IDENTITY_PROVIDER`|`projects/1234567890/locations/global/workloadIdentityPools/github-actions-pool/providers/github-actions-provider`|
