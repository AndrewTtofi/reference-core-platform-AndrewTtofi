module "github_actions_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = module.project-services.project_id
  pool_id     = var.github_actions_pool_id
  provider_id = var.github_actions_provider_id

  sa_mapping = {
    (google_service_account.github_actions_sa.account_id) = {
      sa_name   = google_service_account.github_actions_sa.name
      attribute = "attribute.repository/${var.github_user}/${var.github_repo}"
    }
  }
}
