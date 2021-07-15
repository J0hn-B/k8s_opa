#!/usr/bin/env bash

source linux/./parameters.sh # # # paths adjusted for "make"

echo "==> K3d cluster is deleted"
k3d cluster delete "$CLUSTER_NAME"
