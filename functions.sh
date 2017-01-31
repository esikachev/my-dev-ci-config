#!/bin/bash -x

export CONFIG_PATH='etc/my-dev-server/my-dev-server.conf'

prepare_config(){
    cp etc/my-dev-server/my-dev-server.conf.sample etc/my-dev-server/my-dev-server.conf
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
    git clone https://github.com/${project_name}
}

migrate_db() {
    prepare_config
    sed -i '/log_dir=/c\log_dir=/home/travis/build/esikachev/my-dev-server' ${CONFIG_PATH}
    tox -e venv -- my-dev-migrate --config-file ${CONFIG_PATH}
}

start_server() {
    migrate_db
    tmux new -d 'tox -e venv -- my-dev-server --config-file ${CONFIG_PATH} >> my-dev-server-logs'
}
