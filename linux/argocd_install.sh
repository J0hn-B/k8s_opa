#!/usr/bin/env bash

# Bash color parameters
GREEN='\033[0;32m'
NC='\033[0m'

# Parameters
ARGOCD_CLI_VERSION=$(argocd version --client)

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

echo -e "==> Installing Argo CD applications..."
kubectl apply -f k8s/argocd/applications/
