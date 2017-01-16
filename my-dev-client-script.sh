#!/bin/bash -x

. ${WORKSPACE}/functions.sh

case "${TOX_ENV}" in
        functional)
            get_dependency esikachev/my-dev-server
            cd my-dev-server
            start_server
            cat etc/my-dev-server/my-dev-server.conf
	    tox -e functional
            ;;
        *)
            tox -e "${TOX_ENV}"
            ;;
esac
