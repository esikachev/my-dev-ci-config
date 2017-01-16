#!/bin/bash -x

. ${WORKSPACE}/functions.sh

case "${TOX_ENV}" in
    api)
        start_server
        ;;
    migration)
        migrate_db
        ;;
    functional-client)
        start_server
        get_dependency esikachev/my-dev-client
        cd my-dev-client
        tox -e functional
        cd -;
        ;;
    *)
        tox -e "${TOX_ENV}"
        ;;
esac