#!/usr/bin/env bash

# Parameters
CLUSTER=$(k3d cluster list | grep dev-cluster)
KUBECTL_VERSION=$(kubectl version)
HELM_VERSION=$(helm version)

# Install Kubectl
if [ "$KUBECTL_VERSION" ]; then
    echo "Kubectl is installed"
else
    echo "--> Kubectl is missing"
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl
    kubectl version --client
fi

# Install Helm
if [ "$HELM_VERSION" ]; then
    echo "Helm is installed"
else
    echo "--> Helm is missing"
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh

fi

# Prepare the k3d cluster
if [ "$CLUSTER" ]; then
    echo "Cluster exists"
else
    echo "--> Cluster does not exist"
    wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
    k3d cluster create dev-cluster --agents 2
    k3d kubeconfig merge dev-cluster --switch-context
fi
