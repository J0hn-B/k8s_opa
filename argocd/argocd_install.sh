#!/usr/bin/env bash

# Bash color parameters
GREEN='\033[0;32m'
NC='\033[0m'

# Parameters
ARGOCD_CLI_VERSION=$(argocd version)

# Install Argo CD CLI
if [ "$ARGOCD_CLI_VERSION" ]; then
    echo -e "${GREEN}==> Argo CD:${NC} $ARGOCD_CLI_VERSION"
else
    echo -e "==> Installing Argo CD..."
    sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
    sudo chmod +x /usr/local/bin/argocd
fi

echo -e "==> Create argocd namespace..."
kubectl create namespace argocd

echo -e "==> Installing Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=Available --timeout=360s deploy/argocd-server -n argocd
echo
ARGO_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo)
echo -e "${GREEN}==> Argo CD password:${NC} $ARGO_PASSWORD"
echo

# # # Keep port-forward connection alive
while true; do
    kubectl port-forward svc/argocd-server -n argocd 8080:443
    sleep 3
done

### Login to argocd CLI
#
# argocd login --insecure localhost:8080
#
# argocd cluster add k3d-dev-cluster
#
#  argocd app list
#
# argocd app manifests opa
#
#
#
