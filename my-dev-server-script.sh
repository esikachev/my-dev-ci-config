#!/bin/bash -xe

. "${WORKSPACE}"/functions.sh

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
        get_dependency esikachev/my-dev-client
        cd my-dev-client || exit
        tox -e functional
        cd - || exit;
        ;;
    *)
        tox -e "${TOX_ENV}"
        ;;
esac
