#!/bin/bash -x

. ${WORKSPACE}/functions.sh

case "${TOXENV}" in
    api)
        start_server
        ;;
    migration)
        migrate_db
        ;;
    functional-client)
        start_server
        get_dependency esikachev/my-dev-client
        cd my-dev-client;
        tox -e functional;
        cd -;
        ;;
    *)
        tox -e "${TOXENV}"
        ;;
esac