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

variable "bastion_members" {
  type        = list(string)
  description = "List of IAM resources that need access to the bastion host"
  default     = []
}

variable "environment" {
  type        = string
  description = "Environment name (eg sandbox)"
}
