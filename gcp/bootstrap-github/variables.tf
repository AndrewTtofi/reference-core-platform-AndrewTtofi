variable "gcp_project_id" {
  type        = string
  description = "GCP project id (eg my-sandbox-4b1d)"
}

variable "gcp_region" {
  type        = string
  description = "GCP region (eg europe-west2)"
}

variable "github_sa" {
  type        = string
  description = "GitHub Actions service account name (eg github-actions-sa)"
}

variable "github_sa_role" {
  type        = string
  description = "GitHub Actions service account role (eg roles/owner)"
  default     = "roles/owner"
}

variable "github_user" {
  type        = string
  description = "GitHub user or organization (eg coreeng)"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository (eg reference-core-platform-my-fork)"
}

variable "github_actions_pool_id" {
  type        = string
  description = "GitHub Actions workload identity pool id"
  default     = "github-actions-pool"
}

variable "github_actions_provider_id" {
  type        = string
  description = "GitHub Actions workload identity provider id"
  default     = "github-actions-provider"
}
