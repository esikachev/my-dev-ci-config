#!/bin/bash -xe

mkdir -p /tmp/my-dev-server

export CLIENT_DIR=$(pwd)
export SERVER_DIR=/tmp/my-dev-server

. "${WORKSPACE}"/functions.sh

case "${TOX_ENV}" in
        functional)
            prepare_server
            tox -e functional
            ;;
        cli)
            prepare_server
            tox -e cli
            ;;
        cover)
            prepare_server
            tox -e cover
            ;;
        *)
            tox -e "${TOX_ENV}"
            ;;
esac
