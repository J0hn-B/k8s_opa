#
# Makefile
#

validate_code:
	@echo "==> Lint code before push..."
	./tests/validate_code.sh

	@echo "==> Prepare a k3d cluster..."
	./linux/k3d_prepare.sh


clean:
	@echo "==> Clean up..."	
	./linux/k3d_cleanup.sh