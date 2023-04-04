module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 14.2"

  project_id = var.gcp_project_id

  disable_dependent_services  = false
  disable_services_on_destroy = false

  # https://github.com/terraform-google-modules/terraform-google-github-actions-runners/tree/master/modules/gh-oidc#requirements
  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
  ]
}
