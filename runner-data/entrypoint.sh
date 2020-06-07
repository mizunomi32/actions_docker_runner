#!/bin/bash
if  [ ! -f /actions-runner/run.sh ]; then
    curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz 
    rm -rf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz 
    sudo ./bin/installdependencies.sh
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
if [ ! -f /actions-runner/.runner ]; then
    CONFIGURE_OPTS='--disable-install-rdoc' rbenv install 2.6.6
    rbenv global 2.6.6
    ./autoconf.sh
fi
 ./run.sh
