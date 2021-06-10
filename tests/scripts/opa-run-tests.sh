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
TF_PLAN_NAME=opa

echo "==> Convert plan to JSON..."
cd ../deployment && terraform show -json "$TF_PLAN_NAME" >$TF_PLAN_NAME.json # verify if saving to json is needed in pipelines

echo "==> Load planned values..."
cd ../opa/policy &&
    cat planned_values_template.yml |
    sed -e 's:root-id-1:'"${root_id_1}"':g' \
        -e's:root-id-2:'"${root_id_2}"':g' \
        -e 's:root-id-3:'"${root_id_3}"':g' \
        -e 's:root-name:'"${root_name}"':g' \
        -e's:eastus:'"${location}"':g' >planned_values.yml |
        tee planned_values.yml

echo "==> Running conftest..."
cd ../../deployment &&
    conftest test "$TF_PLAN_NAME.json" \
        -p ../opa/policy \
        -d ../opa/policy/planned_values.yml

#echo "==> Saving test results..."
