#!/bin/bash -x

export ADD_PROJECT_DIR=${HOME}/my-dev-add
export CONFIG_FILE=${ADD_PROJECT_DIR}/etc/my-dev-server/my-dev-server.conf

prepare_config(){
    cp ${CONFIG_FILE}.sample ${CONFIG_FILE}
}

prepare_linux(){
    pip install tox
    sudo apt-get install -y tmux
    mysql -e 'CREATE DATABASE IF NOT EXISTS my_dev;'

}
prepare_osx(){
    pip install tox
    sudo brew install -y tmux
    mysql -e 'CREATE DATABASE IF NOT EXISTS my_dev;'
}

get_dependency() {
    local project_name=$1
    git clone https://github.com/${project_name} ${ADD_PROJECT_DIR}
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
    get_dependency esikachev/my-dev-server
    cd ${ADD_PROJECT_DIR} || exit
    start_server
    cd -

}
