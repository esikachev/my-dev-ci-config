#!/bin/bash -xe

mkdir -p /tmp/my-dev-client

export SERVER_DIR=$(pwd)
export CLIENT_DIR=/tmp/my-dev-client

. "${WORKSPACE}"/functions.sh

get_dependency my-dev-client $CLIENT_DIR

case "${TOX_ENV}" in
    api)
        start_server
        tox -e api
        ;;
    migration)
        migrate_db
        ;;
    functional-client)
        start_server
        cd ${CLIENT_DIR} || exit
        tox -e functional
        cd - || exit;
        ;;
    cli-client)
        start_server
        cd ${CLIENT_DIR} || exit
        tox -e cli
        cd - || exit;
        ;;
    *)
        tox -e "${TOX_ENV}"
        ;;
esac
