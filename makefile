#
# Makefile
#

# # #* Targets execution order
all: validate_code \
prepare_cluster \
install_argocd \
apply_opa_rules \
port_forward_argocd


# # #* Targets
validate_code:
	@echo "==> Lint code before push..."
	./tests/validate_code.sh
prepare_cluster:
	@echo "==> Prepare a k3d cluster..."
	./linux/k3d_prepare.sh
install_argocd:
	@echo "==> Install Argo CD and apps..."
	./linux/argocd_install.sh
apply_opa_rules:
	@echo "==> Apply OPA gatekeeper rules..."
	./linux/opa_gatekeeper.sh
port_forward_argocd:
	@echo "==> Port-forward connection(s) to access from localhost..."
	./linux/port_forward_connections.sh


# # #* Clean up
clean:
	@echo "==> Clean up..."	
	./linux/k3d_cleanup.sh