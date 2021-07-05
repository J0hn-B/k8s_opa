#!/usr/bin/env bash

# Bash color parameters
GREEN='\033[0;32m'
NC='\033[0m'

# Parameters
CLUSTER=$(k3d cluster list | grep dev-cluster)
KUBECTL_VERSION=$(kubectl version --short)
HELM_VERSION=$(helm version --short)
TERRAFORM_VERSION=$(terraform version)

# Install Terraform
if [ "$TERRAFORM_VERSION" ]; then
    echo -e "${GREEN}==> Terraform:${NC} $TERRAFORM_VERSION"
else
    echo -e "==> Installing Terraform..."
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install terraform
fi

# Install Kubectl
if [ "$KUBECTL_VERSION" ]; then
    echo -e "${GREEN}==> Kubectl:${NC} $KUBECTL_VERSION"
else
    echo -e "==> Installing Kubectl..."
    sudo curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    kubectl version --client
fi

# Install Helm
if [ "$HELM_VERSION" ]; then
    echo -e "${GREEN}==> Helm:${NC} $HELM_VERSION"
else
    echo -e "==> Installing Helm..."
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
fi

# Prepare the k3d cluster
if [ "$CLUSTER" ]; then
    echo -e "${GREEN}==> Cluster:${NC} $CLUSTER"
else
    echo -e "==>  Cluster does not exist"
    wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
    k3d cluster create dev-cluster --agents 2
fi
