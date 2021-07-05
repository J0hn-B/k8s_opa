#
# Makefile
#

# # # Targets execution order
all: validate_code \
prepare_cluster \
install_argocd


# # # Targets
validate_code:
	@echo "==> Lint code before push..."
	./tests/validate_code.sh
prepare_cluster:
	@echo "==> Prepare a k3d cluster..."
	./linux/k3d_prepare.sh
install_argocd:
	@echo "==> Install Argo CD..."
	./argocd/argocd_install.sh


# # # Clean up
clean:
	@echo "==> Clean up..."	
	./linux/k3d_cleanup.sh