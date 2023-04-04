

# Set environment to sandbox if not specified
ENV ?= sandbox

# Set terragrunt path for the selected environment
export TERRAGRUNT_WORKING_DIR := environments/$(ENV)/connected-kubernetes

.PHONY: default
default:
	@echo "Usage: "
	@echo "  make tg-fmt|tg-init|tg-validate|tg-plan|tg-apply - run terragrunt command"
	@echo "  make bootstrap - tg apply the bootstrap module"
	@echo "  make update-deps - update dependencies"
	@echo "  make kubeconfig-generate - generate a kubeconfig entry for the cluster"
	@echo "  make iap-tunnel - start IAP tunneling to access ithe cluster"

.PHONY: clean
clean:
	rm -rf ${TERRAGRUNT_WORKING_DIR}/.terraform

.PHONY: tg-fmt
tg-fmt:
	terragrunt fmt -check -recursive --terragrunt-no-auto-init

.PHONY: tg-init
tg-init:
	terragrunt init

.PHONY: tg-validate
tg-validate:
	terragrunt validate

.PHONY: tg-plan
tg-plan:
	terragrunt plan

.PHONY: tg-apply
tg-apply:
	terragrunt apply

.PHONY: bootstrap
bootstrap:
	terragrunt apply --target=module.bootstrap

.PHONY: update-deps
update-deps:
	terragrunt init --upgrade
	terragrunt providers lock --platform=darwin_amd64 --platform=darwin_arm64 --platform=linux_amd64 --platform=linux_arm64 --platform=windows_amd64

.PHONY: kubeconfig-generate
kubeconfig-generate:
	sh -c "$$(terragrunt output -raw kubeconfig_generate_command)"
	sh -c "$$(terragrunt output -raw kubeconfig_set_proxy_command)"

.PHONY: iap-tunnel
iap-tunnel:
	@echo "IAP tunneling to $(ENV) started, hit ^C to stop."
	@sh -c "$$(terragrunt output -raw iap_tunnel_command)" || printf "\nIAP tunneling to $(ENV) stopped.\n"
