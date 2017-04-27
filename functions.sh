#!/bin/bash -x

export CONFIG_FILE=${SERVER_DIR}/etc/my-dev-server/my-dev-server.conf

prepare_config() {
    ls $SERVER_DIR
    cp ${CONFIG_FILE}.sample ${CONFIG_FILE}
}

prepare_linux() {
    pip install tox
    sudo apt-get install -y tmux
    mysql -e 'CREATE DATABASE IF NOT EXISTS my_dev;'
}

prepare_osx() {
    pip install tox
#    brew install mysql
    mysql -e 'CREATE DATABASE IF NOT EXISTS my_dev;'
}

get_dependency() {
    local project_name=$1
    local directory=$2
    git clone https://github.com/esikachev/${project_name} ${directory}
}

migrate_db() {
    prepare_config
    sed -i '/log_dir=/c\log_dir=/home/travis/build/esikachev/my-dev-server' ${CONFIG_FILE}
    tox -e venv -- my-dev-migrate --config-file ${CONFIG_FILE}
}

start_server() {
    migrate_db
    tmux new -d 'tox -e venv -- my-dev-server --config-file ${CONFIG_FILE} >> my-dev-server-logs'
    cat ${CONFIG_FILE}
}

prepare_server() {
    if [[ $TRAVIS_REPO_SLUG != *"server"* ]]; then
        get_dependency my-dev-server $SERVER_DIR
    fi
    cd ${SERVER_DIR} || exit
    start_server
    cd -

}
