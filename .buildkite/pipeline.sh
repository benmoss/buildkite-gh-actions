#!/usr/bin/env bash
set -eu

yq eval '.steps[].agents.queue += env(GITHUB_RUN_ID)' "$(dirname "$0")/pipeline.yaml" | buildkite-agent pipeline upload
