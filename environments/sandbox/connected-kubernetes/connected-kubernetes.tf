module "connected-kubernetes" {
  source = "../../../gcp/modules/connected-kubernetes"

  gcp_project_id = var.gcp_project_id
  gcp_region     = var.gcp_region
  cluster_name   = var.environment

  master_ipv4_cidr_block = "10.0.0.0/28"
  subnet_ip              = "10.10.10.0/24"
  ip_range_pods          = "192.168.0.0/18"
  ip_range_services      = "192.168.64.0/18"

  enable_identity_service = false

  node_pools = [
    {
      name          = format("%s-pool", var.environment)
      machine_type  = "e2-standard-2"
      min_count     = 1
      max_count     = 4
      auto_upgrade  = true
      node_metadata = "GKE_METADATA"
    }
  ]

  bastion_members = concat(
    ["serviceAccount:${var.github_sa}@${var.gcp_project_id}.iam.gserviceaccount.com"],
  var.bastion_members)
}
