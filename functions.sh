#!/bin/bash -x

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
    tox -e venv -- my-dev-migrate --config-file etc/my-dev-server/my-dev-server.conf
}

start_server() {
    migrate_db
    tmux new -d 'tox -e venv -- my-dev-server --config-file etc/my-dev-server/my-dev-server.conf >> my-dev-server-logs'
}
