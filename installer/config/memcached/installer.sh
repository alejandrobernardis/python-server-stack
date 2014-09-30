#!/bin/bash
# Copyright (c) 2014 Asumi Kamikaze Inc.
# Copyright (c) 2014 The Octopus Apps Inc.
# Licensed under the MIT License.
# Author: Alejandro M. Bernardis
# Email: alejandro.bernardis at gmail.com
# Created: 07/03/14 21:04:34

_title "MEMCACHED"

LOCAL_NAME="memcached"
LOCAL_CFG_PATH="${CFG_PATH}/${LOCAL_NAME}"

declare -a LOCAL_FILES=(
    "${LOCAL_CFG_PATH}/etc/sysconfig/memcached"
)

_check_files ${LOCAL_NAME} LOCAL_FILES[@]

yum -y install memcached
chkconfig memcached on
cp -bfv "${LOCAL_CFG_PATH}/etc/sysconfig/memcached" /etc/sysconfig/memcached
ldconfig

cd ${DOWNLOAD_PATH}
wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
tar xfvz libmemcached-1.0.18.tar.gz

cd libmemcached-1.0.18
./configure
make && make install

cd /usr/local/bin
curl -O https://raw.githubusercontent.com/memcached/memcached/master/scripts/memcached-tool
chmod a+x memcached-tool
