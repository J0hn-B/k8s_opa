#!/usr/bin/bash
set -e

#
# Shell Script
# - OPA Run Tests
#
# # Parameters
root_id_1="tv-myorg-1"
root_id_2="myorg-2"
root_id_3="myorg-3"
root_name="My Organization"
location="uksouth"
TF_PLAN_JSON=opa

echo "==> Switching directories..."
cd ../deployment

echo "==> Convert plan to JSON..."
terraform show -json "$TF_PLAN_JSON"

echo "==> Switching directories..."
cd ../opa/policy

echo "==> Load planned values..."
cat planned_values_template.yml |
    sed -e 's:root-id-1:'"${root_id_1}"':g' \
        -e's:root-id-2:'"${root_id_2}"':g' \
        -e 's:root-id-3:'"${root_id_3}"':g' \
        -e 's:root-name:'"${root_name}"':g' \
        -e's:eastus:'"${location}"':g' >planned_values.yml |
    tee planned_values.yml

echo "==> Switching directories..."
cd ../../deployment

echo "==> Running conftest..."
conftest test "$TF_PLAN_JSON.json" \
    -p ../opa/policy \
    -d ../opa/policy/planned_values.yml

#echo "==> Saving test results..."
