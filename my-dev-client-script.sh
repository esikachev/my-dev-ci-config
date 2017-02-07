#!/bin/bash -xe

. "${WORKSPACE}"/functions.sh

case "${TOX_ENV}" in
        functional)
            get_dependency esikachev/my-dev-server
            cd my-dev-server || exit
            start_server
            cat etc/my-dev-server/my-dev-server.conf
            cd -
            tox -e functional
            ;;
        cli)
            get_dependency esikachev/my-dev-server
            cd my-dev-server || exit
            start_server
            cat etc/my-dev-server/my-dev-server.conf
            cd -
            tox -e cli
            ;;
        *)
            tox -e "${TOX_ENV}"
            ;;
esac
