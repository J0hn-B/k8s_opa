#!/usr/bin/env bash

# # # Parameters
CLUSTER_NAME="k3d-dev-0pa"
CLUSTER=$(k3d cluster list | grep $CLUSTER_NAME)
KUBECTL_VERSION=$(kubectl version --short)
HELM_VERSION=$(helm version --short)
YQ_VERSION=$(yq --version)
YQ_DOWNLOAD_VERSION="v4.9.8"
YQ_DOWNLOAD_BINARY="yq_linux_amd64"
REPO=$(git config --local remote.origin.url)

# # # linter-check SC2034: export if used externally
export CLUSTER_NAME
export CLUSTER
export KUBECTL_VERSION
export HELM_VERSION
export YQ_VERSION
export YQ_DOWNLOAD_VERSION
export YQ_DOWNLOAD_BINARY
export REPO
