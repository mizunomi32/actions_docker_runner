#!/bin/bash
if  [ ! -f /actions-runner/run.sh ]; then
    curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz 
    rm -rf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz 
    sudo ./bin/installdependencies.sh
fi
if [ ! -f /actions-runner/.runner ]; then
    ./autoconf.sh
fi
 ./run.sh
