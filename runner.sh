#!/bin/bash -x

export WORKSPACE=$(pwd)/my-dev-ci-config

. ${WORKSPACE}/functions.sh

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    prepare_linux
fi

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    prepare_osx
fi

if [[ 'esikachev/my-dev-client' == $TRAVIS_REPO_SLUG ]]; then
    my-dev-client-script.sh
fi

if [[ 'esikachev/my-dev-server' == $TRAVIS_REPO_SLUG ]]; then
    my-dev-server-script.sh
fi
