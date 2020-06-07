FROM ubuntu:18.04
ENV BUNDLE_FORCE_RUBY_PLATFORM 1
ENV DEBIAN_FRONTEND=noninteractive

ARG BUNDLE_OPTIONS
ARG RUNNER_UID=1000
ARG RUNNER_USER=runner
ARG RUNNER_PASSWORD=runner
ARG RUNNER_VERSION=2.263.0
SHELL ["/bin/bash", "-c"]

RUN apt-get update -y && \
    apt install -y curl sudo build-essential expect nodejs npm yarn ruby bash libreadline-dev zlib1g-dev && \
    mkdir -p /actions-runner && \ 
    useradd -m --uid ${RUNNER_UID} --groups sudo ${RUNNER_USER} \
    && echo ${RUNNER_USER}:${RUNNER_PASSWORD} | chpasswd &&\
    chown -R ${RUNNER_USER} /actions-runner &&\
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common &&\
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - &&\
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" &&\
    apt-get update &&\
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose &&\
    gpasswd -a ${RUNNER_USER} docker &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*
USER ${RUNNER_USER}
WORKDIR /actions-runner


CMD ./entrypoin.sh
