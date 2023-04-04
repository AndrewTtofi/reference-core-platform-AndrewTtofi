variable "gcp_project_id" {
  type        = string
  description = "GCP project id (eg my-sandbox-4b1d)"
}

variable "gcp_region" {
  type        = string
  description = "GCP region (eg europe-west2)"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = "default-core-platform"
}

variable "bastion_members" {
  type        = list(string)
  description = "List of IAM resources that need access to the bastion host"
  default     = []
}

variable "subnet_ip" {
  type        = string
  description = "The cidr range of the subnet"
  default     = "10.10.10.0/24"
}

variable "ip_range_pods" {
  type        = string
  description = "The cidr range of the secondary ip range to use for pods"
  default     = "192.168.0.0/18"
}

variable "ip_range_services" {
  type        = string
  description = "The cidr range of the secondary ip range to use for sevices"
  default     = "192.168.64.0/18"
}

variable "zones" {
  type        = list(string)
  description = "The zones to host the cluster in"
  default     = []
}

variable "network_project_id" {
  type        = string
  description = "The project ID of the shared VPC's host (for shared vpc support)"
  default     = ""
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. The module enforces certain minimum versions to ensure that specific features are available. "
  default     = null
}

variable "release_channel" {
  type        = string
  description = "(Beta) The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`."
  default     = "REGULAR"
}

variable "gateway_api_channel" {
  type        = string
  description = "The gateway api channel of this cluster. Accepted values are `CHANNEL_STANDARD` and `CHANNEL_DISABLED`."
  default     = null
}

variable "horizontal_pod_autoscaling" {
  type        = bool
  description = "Enable horizontal pod autoscaling addon"
  default     = true
}

variable "http_load_balancing" {
  type        = bool
  description = "Enable httpload balancer addon. The addon allows whoever can create Ingress objects to expose an application to a public IP. Network policies or Gatekeeper policies should be used to verify that only authorized applications are exposed."
  default     = true
}

variable "datapath_provider" {
  type        = string
  description = "The desired datapath provider for this cluster. By default, `ADVANCED_DATAPATH` enables Dataplane-V2 feature. `DATAPATH_PROVIDER_UNSPECIFIED` enables the IPTables-based kube-proxy implementation as a fallback since upgrading to V2 requires a cluster re-creation."
  default     = "ADVANCED_DATAPATH"
}

variable "maintenance_start_time" {
  type        = string
  description = "Time window specified for daily maintenance operations in RFC3339 format"
  default     = "05:00"
}

variable "maintenance_exclusions" {
  type        = list(object({ name = string, start_time = string, end_time = string, exclusion_scope = string }))
  description = "List of maintenance exclusions. A cluster can have up to three"
  default     = []
}

variable "maintenance_end_time" {
  type        = string
  description = "Time window specified for recurring maintenance operations in RFC3339 format"
  default     = ""
}

variable "maintenance_recurrence" {
  type        = string
  description = "Frequency of the recurring maintenance window in RFC5545 format."
  default     = ""
}

variable "initial_node_count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool."
  default     = 0
}

variable "node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pools"

  default = [
    {
      name = "default-node-pool"
    },
  ]
}

variable "windows_node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pools"
  default     = []
}

variable "node_pools_labels" {
  type        = map(map(string))
  description = "Map of maps containing node labels by node-pool name"

  default = {
    all               = {}
    default-node-pool = {}
  }
}

variable "node_pools_resource_labels" {
  type        = map(map(string))
  description = "Map of maps containing resource labels by node-pool name"

  default = {
    all               = {}
    default-node-pool = {}
  }
}

variable "node_pools_metadata" {
  type        = map(map(string))
  description = "Map of maps containing node metadata by node-pool name"

  default = {
    all               = {}
    default-node-pool = {}
  }
}

variable "node_pools_taints" {
  type        = map(list(object({ key = string, value = string, effect = string })))
  description = "Map of lists containing node taints by node-pool name"

  default = {
    all               = []
    default-node-pool = []
  }
}

variable "node_pools_tags" {
  type        = map(list(string))
  description = "Map of lists containing node network tags by node-pool name"

  default = {
    all               = []
    default-node-pool = []
  }
}

variable "node_pools_oauth_scopes" {
  type        = map(list(string))
  description = "Map of lists containing node oauth scopes by node-pool name"

  default = {
    all               = ["https://www.googleapis.com/auth/cloud-platform"]
    default-node-pool = []
  }
}

variable "cluster_autoscaling" {
  type = object({
    enabled             = bool
    autoscaling_profile = string
    min_cpu_cores       = number
    max_cpu_cores       = number
    min_memory_gb       = number
    max_memory_gb       = number
    gpu_resources       = list(object({ resource_type = string, minimum = number, maximum = number }))
    auto_repair         = bool
    auto_upgrade        = bool
  })
  default = {
    enabled             = false
    autoscaling_profile = "BALANCED"
    max_cpu_cores       = 0
    min_cpu_cores       = 0
    max_memory_gb       = 0
    min_memory_gb       = 0
    gpu_resources       = []
    auto_repair         = true
    auto_upgrade        = true
  }
  description = "Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling)"
}

variable "stub_domains" {
  type        = map(list(string))
  description = "Map of stub domains and their resolvers to forward DNS queries for a certain domain to an external DNS server"
  default     = {}
}

variable "upstream_nameservers" {
  type        = list(string)
  description = "If specified, the values replace the nameservers taken by default from the node’s /etc/resolv.conf"
  default     = []
}

variable "logging_service" {
  type        = string
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none"
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  type        = string
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none"
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "monitoring_enable_managed_prometheus" {
  type        = bool
  description = "(Beta) Configuration for Managed Service for Prometheus. Whether or not the managed collection is enabled."
  default     = false
}

variable "grant_registry_access" {
  type        = bool
  description = "Grants created cluster-specific service account storage.objectViewer role."
  default     = true
}

variable "registry_project_ids" {
  type        = list(string)
  description = "Projects holding Google Container Registries. If empty, we use the cluster project. If a service account is created and the `grant_registry_access` variable is set to `true`, the `storage.objectViewer` role is assigned on these projects."
  default     = []
}

variable "cluster_resource_labels" {
  type        = map(string)
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  default     = {}
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network"
  default     = "10.0.0.0/28"
}

variable "add_cluster_firewall_rules" {
  type        = bool
  description = "Create additional firewall rules"
  default     = false
}

variable "firewall_priority" {
  type        = number
  description = "Priority rule for firewall rules"
  default     = 1000
}

variable "firewall_inbound_ports" {
  type        = list(string)
  description = "List of TCP ports for admission/webhook controllers"
  default     = ["8443", "9443", "15017"]
}

variable "compute_engine_service_account" {
  type        = string
  description = "Use the given service account for nodes rather than creating a new dedicated service account."
  default     = ""
}

variable "enable_identity_service" {
  type        = bool
  description = "Enable the Identity Service component, which allows customers to use external identity providers with the K8S API."
  default     = false
}

variable "enable_pod_security_policy" {
  type        = bool
  description = "enabled - Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created."
  default     = false
}
