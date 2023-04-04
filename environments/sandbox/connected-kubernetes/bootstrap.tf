module "bootstrap" {
  source = "../../../gcp/modules/bootstrap"

  gcp_project_id = var.gcp_project_id
}
