module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 14.2"

  project_id = var.gcp_project_id

  disable_dependent_services  = false
  disable_services_on_destroy = false

  activate_apis = [
    "binaryauthorization.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "serviceusage.googleapis.com",
    "stackdriver.googleapis.com",
  ]
}
