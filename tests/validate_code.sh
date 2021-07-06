#!/usr/bin/env bash

# Lint code before push
docker run --rm -e KUBERNETES_KUBEVAL_OPTIONS=--ignore-missing-schemas -e RUN_LOCAL=true -v /home/johnb/temp/opa:/tmp/lint ghcr.io/github/super-linter:slim-v4
