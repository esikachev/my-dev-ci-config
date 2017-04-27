#!/bin/bash -xe

export WORKSPACE
WORKSPACE=$(pwd)/my-dev-ci-config

# shellcheck source=/dev/null
. "${WORKSPACE}"/functions.sh

if [[ 'esikachev/my-dev-client' == "$TRAVIS_REPO_SLUG" ]]; then
    "${WORKSPACE}"/my-dev-client-script.sh
fi

if [[ 'esikachev/my-dev-server' == "$TRAVIS_REPO_SLUG" ]]; then
    "${WORKSPACE}"/my-dev-server-script.sh
fi
