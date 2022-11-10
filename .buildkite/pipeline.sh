#!/usr/bin/env bash
set -eu

yq eval '.steps[].agents.queue += env(GITHUB_REF)' "$(dirname "$0")/pipeline.yaml" | buildkite-agent pipeline upload
