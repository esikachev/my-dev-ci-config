#!/bin/bash -x

. functions.sh

case "${TOXENV}" in
        functional)
            get_dependency esikachev/my-dev-server
            cd my-dev-server;
            start_server;
            cat etc/my-dev-server/my-dev-server.conf;
            cd -;
            ;;
        *)
            tox -e "${TOXENV}";
            ;;
esac
