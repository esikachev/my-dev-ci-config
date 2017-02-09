#!/bin/bash -xe

. "${WORKSPACE}"/functions.sh

case "${TOX_ENV}" in
        functional)
            get_dependency esikachev/my-dev-server
            cd ~/my-dev-server || exit
            start_server
            cd -
            tox -e functional
            ;;
        cli)
            get_dependency esikachev/my-dev-server
            cd ~/my-dev-server || exit
            start_server
            cd -
            tox -e cli
            ;;
        cover)
            get_dependency esikachev/my-dev-server
            cd ~/my-dev-server || exit
            start_server
            cd -
            tox -e cover
            ;;
        *)
            tox -e "${TOX_ENV}"
            ;;
esac
