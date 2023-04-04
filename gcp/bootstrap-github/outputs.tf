output "github_actions_service_account" {
  description = "GitHub Actions service account email"
  value       = google_service_account.github_actions_sa.email
}

output "github_actions_workload_identity_provider" {
  description = "GitHub Actions workload identity provider name"
  value       = module.github_actions_oidc.provider_name
}
