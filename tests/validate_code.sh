#!/usr/bin/env bash

# Lint code before push
docker run --rm -e RUN_LOCAL=true -v /home/johnb/temp/opa:/tmp/lint ghcr.io/github/super-linter:slim-v4
