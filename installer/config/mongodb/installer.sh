#!/bin/bash
# Copyright (c) 2014 Asumi Kamikaze Inc.
# Copyright (c) 2014 The Octopus Apps Inc.
# Licensed under the MIT License.
# Author: Alejandro M. Bernardis
# Email: alejandro.bernardis at gmail.com
# Created: 07/03/14 21:04:34

_title "MONGODB"

LOCAL_NAME="mongodb"
LOCAL_CFG_PATH="${CFG_PATH}/${LOCAL_NAME}"
LOCAL_DOMAIN="127.0.0.1"
LOCAL_MONGO=/usr/bin/mongo

declare -a LOCAL_FILES=(
    "${LOCAL_CFG_PATH}/data/etc/mongod/keys/r_main_s_all"
    "${LOCAL_CFG_PATH}/data/etc/mongod/keys/r_track_s_all"
    "${LOCAL_CFG_PATH}/data/etc/mongod/r_main_s_0_27000.yaml"
    "${LOCAL_CFG_PATH}/data/etc/mongod/r_main_s_1_27001.yaml"
    "${LOCAL_CFG_PATH}/data/etc/mongod/r_main_s_2_27002.yaml"
    "${LOCAL_CFG_PATH}/data/etc/mongod/r_main_s_3_27003.yaml"
    "${LOCAL_CFG_PATH}/data/etc/mongod/r_track_s_0_27100.yaml"
    "${LOCAL_CFG_PATH}/etc/rc.d/init.d/r-main-s-0"
    "${LOCAL_CFG_PATH}/etc/rc.d/init.d/r-main-s-1"
    "${LOCAL_CFG_PATH}/etc/rc.d/init.d/r-main-s-2"
    "${LOCAL_CFG_PATH}/etc/rc.d/init.d/r-main-s-3"
    "${LOCAL_CFG_PATH}/etc/rc.d/init.d/r-track-s-0"
    "${LOCAL_CFG_PATH}/etc/yum.repos.d/10gen.repo"
    "${LOCAL_CFG_PATH}/tmp/r_main_s_all.mjs"
    "${LOCAL_CFG_PATH}/tmp/r_track_s_all.mjs"
)

_check_files ${LOCAL_NAME} LOCAL_FILES[@]

cp -bfv "${LOCAL_CFG_PATH}/etc/yum.repos.d/10gen.repo" /etc/yum.repos.d/10gen.repo
yum -y install mongodb-org-server mongodb-org-shell mongodb-org-tools
chkconfig mongod off

mkdir -p /data/db/r/main/s/{0,1,2,3} \
         /data/db/r/track/s/{0,1,2,3} \
         /data/etc/mongod/keys \
         /data/var/log/mongod \
         /data/var/run/mongod \

cp -bfv "${LOCAL_CFG_PATH}/data/etc/mongod/keys/r_main_s_all" /data/etc/mongod/keys/r_main_s_all
cp -bfv "${LOCAL_CFG_PATH}/data/etc/mongod/keys/r_track_s_all" /data/etc/mongod/keys/r_track_s_all
cp -bfv "${LOCAL_CFG_PATH}/data/etc/mongod/r_main_s_0_27000.yaml" /data/etc/mongod/r_main_s_0_27000.yaml
cp -bfv "${LOCAL_CFG_PATH}/data/etc/mongod/r_main_s_1_27001.yaml" /data/etc/mongod/r_main_s_1_27001.yaml
cp -bfv "${LOCAL_CFG_PATH}/data/etc/mongod/r_main_s_2_27002.yaml" /data/etc/mongod/r_main_s_2_27002.yaml
cp -bfv "${LOCAL_CFG_PATH}/data/etc/mongod/r_main_s_3_27003.yaml" /data/etc/mongod/r_main_s_3_27003.yaml
cp -bfv "${LOCAL_CFG_PATH}/data/etc/mongod/r_track_s_0_27100.yaml" /data/etc/mongod/r_track_s_0_27100.yaml

chown -R mongod:mongod /data/db \
                       /data/etc/mongod \
                       /data/var/log/mongod \
                       /data/var/run/mongod

chmod -R 700 /data/etc/mongod/keys/*

declare -a SERVICES=(
    r-main-s-0
    r-main-s-1
    r-main-s-2
    r-main-s-3
    r-track-s-0
)

for srv in "${SERVICES[@]}"
do
    cp -bfv ${LOCAL_CFG_PATH}/etc/rc.d/init.d/${srv} /etc/rc.d/init.d/${srv}
    chmod a+x /etc/rc.d/init.d/${srv}
    chkconfig --add ${srv}
    chkconfig ${srv} on
    service ${srv} start
done

sleep 60
${LOCAL_MONGO} ${LOCAL_DOMAIN}:27000 --shell --norc "${LOCAL_CFG_PATH}/tmp/r_main_s_all.mjs"
${LOCAL_MONGO} ${LOCAL_DOMAIN}:27100 --shell --norc "${LOCAL_CFG_PATH}/tmp/r_track_s_all.mjs"
