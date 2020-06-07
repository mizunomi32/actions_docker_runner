#!/bin/bash

if [ -z "${RUNNER_NAME}" ]; then
  echo "RUNNER_NAME must be set" 1>&2
  exit 1
fi

if [ -z "${OWNER}" ]; then
  echo "OWNER must be set" 1>&2
  exit 1
fi

if [ -z "${REPO}" ]; then
  echo "REPO must be set" 1>&2
  exit 1
fi

if [ -z "${TOKEN}" ]; then
  echo "TOKEN must be set" 1>&2
  exit 1
fi

expect -c "
set timeout 10
spawn ./config.sh --url https://github.com/${OWNER}/${REPO} --token ${TOKEN}
expect \"Enter the name of runner:\"
send \"${RUNNER_NAME}\n\"
expect \"Enter any additional labels (ex. label-1,label-2):\"
send \"\n\"
expect \"Enter name of work folder:\"
send \"\n\"
expect \"$\"
exit 0
"