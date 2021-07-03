#!/usr/bin/env bash

# Bash color parameters
GREEN='\033[0;32m'
NC='\033[0m'

# Parameters

echo -e "==> Create argocd namespace..."
kubectl create namespace argocd

echo -e "==> Installing Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
