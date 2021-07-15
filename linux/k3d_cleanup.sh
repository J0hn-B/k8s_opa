#!/usr/bin/env bash

source linux/./parameters.sh

echo "==> K3d cluster is deleted"
k3d cluster delete "$CLUSTER_NAME"
