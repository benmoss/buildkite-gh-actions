# GitHub Action to run a Buildkite agent
[![Build status](https://badge.buildkite.com/8abe1b56256f8d8dacde7255e3f37a4b81c160a082cc44a6b3.svg)](https://buildkite.com/superorbital/buildkite-gh-actions)

## But why?
Buildkite is a great CI platform, but GHA has the advantage for open-source/small scale projects with its free tier of runners. This action lets you run Buildkite jobs from your GHA runner, so you can CI while you CI 😺.

## Example usage

```yaml
name: buildkite-agent

on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  buildkite:
    runs-on: ubuntu-latest
    steps:
      - uses: benmoss/buildkite-gh-actions@v1
        with:
          token: ${{ secrets.buildkite_token }}
```

## How's it work
When the action is triggered, it starts the agent and starts polling for builds from Buildkite. There's a default 20s timeout after which the agent will shut itself down if its not processing any builds. This gives you a pretty good balance of running all the builds triggered by your commit, but not sticking around longer than needed.

There's a slightly weird correspondence problem of ensuring that your agent picks up the builds for the specific PR/commit/whatever that it's being triggered by. If you have two builds going at the same time, by default they might be run by an agent that was triggered by a different event. One workaround I have played around with [in this repo]([url](https://github.com/benmoss/buildkite-gh-actions/blob/55034d4542236c11e1deeba057b07e906ae9dec1/.buildkite/pipeline.sh#L4)) is to use dynamic pipelines to set the GitHub run ID the queue name for every step, so that you can have more of a guarantee that the same agent will pick up all the work. 🤷‍♂️ maybe you can come up with a better solution if its a problem for your use-case!
