module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"

  project_id = module.project-services.project_id
  name       = var.cluster_name

  region             = var.gcp_region
  zones              = var.zones
  network            = module.vpc.network_name
  network_project_id = var.network_project_id

  kubernetes_version  = var.kubernetes_version
  release_channel     = var.release_channel
  gateway_api_channel = var.gateway_api_channel

  master_authorized_networks = [{
    cidr_block   = "${module.bastion.ip_address}/32"
    display_name = "Bastion Host"
  }]

  subnetwork        = module.vpc.subnets_names[0]
  ip_range_pods     = module.vpc.subnets_secondary_ranges[0].*.range_name[0]
  ip_range_services = module.vpc.subnets_secondary_ranges[0].*.range_name[1]

  disable_default_snat = false

  add_cluster_firewall_rules = var.add_cluster_firewall_rules
  firewall_priority          = var.firewall_priority
  firewall_inbound_ports     = var.firewall_inbound_ports

  horizontal_pod_autoscaling = var.horizontal_pod_autoscaling
  http_load_balancing        = var.http_load_balancing

  datapath_provider = var.datapath_provider
  network_policy    = var.datapath_provider == "ADVANCED_DATAPATH" ? false : true

  maintenance_start_time = var.maintenance_start_time
  maintenance_end_time   = var.maintenance_end_time
  maintenance_recurrence = var.maintenance_recurrence
  maintenance_exclusions = var.maintenance_exclusions

  remove_default_node_pool = true
  initial_node_count       = (var.initial_node_count == 0) ? 1 : var.initial_node_count

  node_pools                 = var.node_pools
  windows_node_pools         = var.windows_node_pools
  node_pools_labels          = var.node_pools_labels
  node_pools_resource_labels = var.node_pools_resource_labels
  node_pools_metadata        = var.node_pools_metadata
  node_pools_taints          = var.node_pools_taints
  node_pools_tags            = var.node_pools_tags

  node_pools_oauth_scopes = var.node_pools_oauth_scopes

  cluster_autoscaling = var.cluster_autoscaling

  stub_domains         = var.stub_domains
  upstream_nameservers = var.upstream_nameservers

  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service

  monitoring_enable_managed_prometheus = var.monitoring_enable_managed_prometheus

  create_service_account = var.compute_engine_service_account == "" ? true : false
  service_account        = var.compute_engine_service_account
  registry_project_ids   = var.registry_project_ids
  grant_registry_access  = var.grant_registry_access

  issue_client_certificate = false

  cluster_resource_labels = var.cluster_resource_labels

  master_ipv4_cidr_block = var.master_ipv4_cidr_block

  enable_private_endpoint       = true
  deploy_using_private_endpoint = true
  enable_private_nodes          = true

  enable_binary_authorization = true

  enable_identity_service = var.enable_identity_service

  enable_pod_security_policy = var.enable_pod_security_policy
}
