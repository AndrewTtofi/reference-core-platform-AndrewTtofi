output "name" {
  description = "Cluster name"
  value       = module.connected-kubernetes.name
}

output "iap_tunnel_command" {
  description = "gcloud command to ssh and port forward to the bastion host command without starting a shell"
  value       = module.connected-kubernetes.iap_tunnel_command
}

output "kubeconfig_generate_command" {
  description = "gcloud get-credentials command to generate kubeconfig for the private cluster"
  value       = module.connected-kubernetes.kubeconfig_generate_command
}

output "kubeconfig_set_proxy_command" {
  description = "kubectl config set command to add proxy-url via the IAP tunnel for the private cluster"
  value       = module.connected-kubernetes.kubeconfig_set_proxy_command
}
