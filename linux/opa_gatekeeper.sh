#!/usr/bin/env bash

kubectl apply -f opa_gatekeeper/ConstraintTemplate.yaml
wait
kubectl apply -f opa_gatekeeper/Constraints.yaml
wait
