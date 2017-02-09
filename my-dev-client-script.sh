#!/bin/bash -xe

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
