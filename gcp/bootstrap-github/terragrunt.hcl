locals {
  config = yamldecode(file("config.yaml"))
}

inputs = {
  gcp_project_id = local.config.gcp_project_id
  gcp_region     = local.config.gcp_region
  github_sa      = local.config.github_sa
  github_user    = local.config.github_user
  github_repo    = local.config.github_repo
}

remote_state {
  backend = "gcs"

  config = {
    project  = local.config.gcp_project_id
    location = local.config.gcp_region
    bucket   = "tfstate-${local.config.gcp_project_id}"
    prefix   = "terraform/state/bootstrap-github-${local.config.gcp_project_id}"

    enable_bucket_policy_only = true

    gcs_bucket_labels = {
      owner = "terragrunt"
      name  = "terraform_state"
    }
  }
}
