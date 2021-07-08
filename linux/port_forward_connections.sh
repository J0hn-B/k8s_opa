#!/usr/bin/env bash

# # # Keep port-forward connection alive
while true; do
    kubectl port-forward svc/argocd-server -n argocd 8080:443
    sleep 3
done
