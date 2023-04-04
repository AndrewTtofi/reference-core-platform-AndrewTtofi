resource "google_service_account" "github_actions_sa" {
  project    = module.project-services.project_id
  account_id = var.github_sa
}

resource "google_project_iam_member" "github_actions_sa" {
  project = module.project-services.project_id
  role    = var.github_sa_role
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
}
