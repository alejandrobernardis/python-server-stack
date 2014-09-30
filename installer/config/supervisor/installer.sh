#!/bin/bash
# Copyright (c) 2014 Asumi Kamikaze Inc.
# Copyright (c) 2014 The Octopus Apps Inc.
# Licensed under the MIT License.
# Author: Alejandro M. Bernardis
# Email: alejandro.bernardis at gmail.com
# Created: 07/03/14 21:04:34

_title "SUPERVISOR"

LOCAL_NAME="supervisor"
LOCAL_CFG_PATH="${CFG_PATH}/${LOCAL_NAME}"

declare -a LOCAL_FILES=(
    "${LOCAL_CFG_PATH}/data/etc/supervisord/backend.conf"
    "${LOCAL_CFG_PATH}/data/etc/supervisord/backoffice.conf"
    "${LOCAL_CFG_PATH}/data/etc/supervisord/tasks.conf"
    "${LOCAL_CFG_PATH}/etc/rc.d/init.d/supervisord"
    "${LOCAL_CFG_PATH}/etc/supervisord.conf"
)

_check_files ${LOCAL_NAME} LOCAL_FILES[@]

groupadd -r supervisord

useradd -M -r -g supervisord \
        -G www \
        -d /var/lib/supervisord \
        -s /bin/false \
        -c "Supervisor" supervisord > /dev/null 2>&1

mkdir -p /data/etc/supervisord \
         /data/var/log/supervisord \
         /data/var/run/supervisord \
         /data/var/log/celeryd \
         /data/var/run/celeryd

cp -bfv "${LOCAL_CFG_PATH}/data/etc/supervisord/backend.conf" /data/etc/supervisord/backend.conf
cp -bfv "${LOCAL_CFG_PATH}/data/etc/supervisord/backoffice.conf" /data/etc/supervisord/backoffice.conf
cp -bfv "${LOCAL_CFG_PATH}/data/etc/supervisord/tasks.conf" /data/etc/supervisord/tasks.conf
cp -bfv "${LOCAL_CFG_PATH}/etc/rc.d/init.d/supervisord" /etc/rc.d/init.d/supervisord
cp -bfv "${LOCAL_CFG_PATH}/etc/supervisord.conf" /etc/supervisord.conf

chown -R supervisord:supervisord /data/etc/supervisord \
                                 /data/var/log/supervisord \
                                 /data/var/run/supervisord \
                                 /data/var/log/celeryd \
                                 /data/var/run/celeryd

chmod a+x /etc/rc.d/init.d/supervisord
chkconfig --add supervisord
chkconfig supervisord on
