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
  apt install curl sudo build-essential expect -y  && \
  mkdir -p /actions-runner && \ 
  useradd -m --uid ${RUNNER_UID} --groups sudo ${RUNNER_USER} \
  && echo ${RUNNER_USER}:${RUNNER_PASSWORD} | chpasswd &&\
  chown -R ${RUNNER_USER} /actions-runner
USER ${RUNNER_USER}
WORKDIR /actions-runner

CMD ./entrypoin.sh
