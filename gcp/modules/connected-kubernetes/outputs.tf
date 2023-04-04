output "name" {
  description = "Cluster name"
  value       = module.gke.name
}

output "iap_tunnel_command" {
  description = "gcloud command to ssh and port forward to the bastion host command without starting a shell"
  value       = format("gcloud beta compute ssh %s --tunnel-through-iap --project %s --zone %s -- -L8888:127.0.0.1:8888 -N -n -q", module.bastion.hostname, var.gcp_project_id, local.bastion_zone)
}

output "kubeconfig_generate_command" {
  description = "gcloud get-credentials command to generate kubeconfig for the private cluster"
  value       = format("gcloud container clusters get-credentials --project %s --zone %s --internal-ip %s", var.gcp_project_id, module.gke.location, module.gke.name)
}

output "kubeconfig_set_proxy_command" {
  description = "kubectl config set command to add proxy-url via the IAP tunnel for the private cluster"
  value       = format("kubectl config set clusters.gke_%s_%s_%s.proxy-url http://localhost:8888", var.gcp_project_id, module.gke.location, module.gke.name)
}
