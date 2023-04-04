locals {
  bastion_name = format("%s-bastion", var.cluster_name)
  bastion_zone = format("%s-a", var.gcp_region)
}

module "bastion" {
  source  = "terraform-google-modules/bastion-host/google"
  version = "~> 5.2"

  project        = module.project-services.project_id
  host_project   = module.project-services.project_id
  network        = module.vpc.network_self_link
  subnet         = module.vpc.subnets_self_links[0]
  name           = local.bastion_name
  zone           = local.bastion_zone
  image_project  = "debian-cloud"
  machine_type   = "e2-micro"
  startup_script = <<-EOT
  sudo apt-get update -y
  sudo apt-get install -y tinyproxy
EOT
  members        = var.bastion_members
  shielded_vm    = "false"
}
