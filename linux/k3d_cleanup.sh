#!/usr/bin/env bash

echo "==> K3d cluster is deleted"
k3d cluster delete dev-cluster

# echo "==> Delete all docker containers"
# docker rm -f "$(docker ps -a -q)"

# echo "==> Delete all docker volumes"
# docker volume rm "$(docker volume ls -q)"
