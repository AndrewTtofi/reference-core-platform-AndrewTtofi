locals {
  network_name           = format("%s-network", var.cluster_name)
  subnet_name            = format("%s-subnet", var.cluster_name)
  ip_range_pods_name     = format("%s-pods-ip-range", var.cluster_name)
  ip_range_services_name = format("%s-services-ip-range", var.cluster_name)
  router_name            = format("%s-router", var.cluster_name)
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = ">= 6.0"

  project_id   = module.project-services.project_id
  network_name = local.network_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = local.subnet_name
      subnet_ip             = var.subnet_ip
      subnet_region         = var.gcp_region
      subnet_private_access = true
    }
  ]
  secondary_ranges = {
    (local.subnet_name) = [
      {
        range_name    = local.ip_range_pods_name
        ip_cidr_range = var.ip_range_pods
      },
      {
        range_name    = local.ip_range_services_name
        ip_cidr_range = var.ip_range_services
      },
    ]
  }
}

module "cloud-nat" {
  source  = "terraform-google-modules/cloud-nat/google"
  version = ">= 2.2"

  project_id    = module.project-services.project_id
  region        = var.gcp_region
  network       = module.vpc.network_self_link
  router        = local.router_name
  create_router = true
}
