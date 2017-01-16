#!/bin/bash -x

. functions.sh;

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    prepare_linux
fi

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    prepare_osx
fi

if [[ 'client' ~= $TRAVIS_REPO_SLUG ]]; then
    my-dev-client-script.sh
fi

if [[ 'server' ~= $TRAVIS_REPO_SLUG ]]; then
    my-dev-server-script.sh
fi
