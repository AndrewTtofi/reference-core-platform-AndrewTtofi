# Reference Core Platform (GCP)

This directory contains terraform code for provisioning and configuring reference Core Platform instances on GCP.

The `connected-kubernetes` terraform module is based on [Safer Cluster](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/blob/master/modules/safer-cluster/README.md), which fixes a set of parameters to values suggested in the [GKE hardening guide](https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster), the CIS framework, and other best practices.

Access to the control plane is via a bastion host utilizing [Identity-Aware Proxy](https://cloud.google.com/iap/) without an external ip address that runs [tinyproxy](https://tinyproxy.github.io/) to proxy calls to the Kubernetes API, which enables easy and secure access for testing and development.

## Prerequisites
- A GCP project and sufficient access to deploy to it
- [`gcloud`](https://cloud.google.com/sdk/docs/install) (eg `brew install --cask google-cloud-sdk` on macOS)
- [`kubectl`](https://kubernetes.io/docs/tasks/tools/) (eg `brew install kubectl` on macOS)
- [`gke-gcloud-auth-plugin`](https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke) (eg `gcloud components install gke-gcloud-auth-plugin`)
- [`terraform`](https://developer.hashicorp.com/terraform/downloads) (eg `brew install terraform` on macOS)
- [`terragrunt`](https://terragrunt.gruntwork.io/docs/getting-started/install/) (eg `brew install terragrunt` on macOS)
- `make`

## Setup

To deploy a reference Core Platform instance, fork this repo and:

1. Edit `environments/sandbox/config.yaml` to specify the GCP project id and region to use

2. Run `make bootstrap` to prepare the target GCP project (eg enabling services)

3. Run `make tg-apply` (it should take 10-15 minutes), and/or follow the [bootstrap-github](bootstrap-github/) process to setup GitHub Actions CI/CD

## Usage

To connect to the cluster's control plane:

1. Run `make kubeconfig-generate` to generate a kubeconfig entry for the cluster

2. Run `make iap-tunnel` to start port forwarding to the bastion host through an IAP tunnel

3. You can now run `kubectl` commands, which will be proxied via the bastion host through the IAP tunnel
