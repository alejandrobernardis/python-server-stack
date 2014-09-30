#!/bin/bash
# Copyright (c) 2014 Asumi Kamikaze Inc.
# Copyright (c) 2014 The Octopus Apps Inc.
# Licensed under the MIT License.
# Author: Alejandro M. Bernardis
# Email: alejandro.bernardis at gmail.com
# Created: 07/03/14 20:40:43

# Utils
source ./common.sh
_title "INSTALLER (start)"

# Paths
ROOT_PATH=`pwd`
CFG_PATH="${ROOT_PATH}/config"
DATA_PATH="/data"
DEPLOY_PATH="/deploy"
BACKUP_PATH="/root/backups"
DOWNLOAD_PATH="/root/downloads"

# Installers
_title_break "Install configuration..."

declare -a INSTALLERS=(
    "${CFG_PATH}/linux/installer.sh"
    "${CFG_PATH}/memcached/installer.sh"
    "${CFG_PATH}/mongodb/installer.sh"
    "${CFG_PATH}/nginx/installer.sh"
    "${CFG_PATH}/erlang/installer.sh"
    "${CFG_PATH}/rabbitmq/installer.sh"
    "${CFG_PATH}/python/installer.sh"
    "${CFG_PATH}/celery/installer.sh"
    "${CFG_PATH}/supervisor/installer.sh"
)

for installer in "${INSTALLERS[@]}"
do
    if [ ! -e ${installer} ]; 
    then
        echo "(e): File not found: ${installer}"
        exit 3
    else
        source ${installer}
    fi
done

# Verifications
_title_break "Verify configuration..."

echo -n '* Nginx........ '
[ ! -e /usr/sbin/nginx            ] && echo 'error' || echo 'ok'
echo -n '* Memcached.... '
[ ! -e /usr/bin/memcached         ] && echo 'error' || echo 'ok'
echo -n '* RabbitMQ..... '
[ ! -e /usr/sbin/rabbitmq-server  ] && echo 'error' || echo 'ok'
echo -n '* Erlang....... '
[ ! -e /usr/bin/erl               ] && echo 'error' || echo 'ok'
echo -n '* Python....... '
[ ! -e /usr/local/bin/python2.7   ] && echo 'error' || echo 'ok'
echo -n '* Supervisor... '
[ ! -e /usr/local/bin/supervisord ] && echo 'error' || echo 'ok'
echo -n '* Celery....... '
[ ! -e /usr/local/bin/celery      ] && echo 'error' || echo 'ok'
echo -n '* Mongo........ '
[ ! -e /usr/bin/mongod            ] && echo 'error' || echo 'ok'
echo ""

# ~
_title_break "C'est fini!~"
