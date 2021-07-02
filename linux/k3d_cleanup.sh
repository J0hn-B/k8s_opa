#!/usr/bin/env bash

echo "==> K3d cluster is deleted"
k3d cluster delete dev-cluster
