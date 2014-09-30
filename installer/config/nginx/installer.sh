#!/bin/bash
# Copyright (c) 2014 Asumi Kamikaze Inc.
# Copyright (c) 2014 The Octopus Apps Inc.
# Licensed under the MIT License.
# Author: Alejandro M. Bernardis
# Email: alejandro.bernardis at gmail.com
# Created: 07/03/14 21:04:34

# -- View: 
# http://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html

_title "NGINX"

LOCAL_NAME="nginx"
LOCAL_CFG_PATH="${CFG_PATH}/${LOCAL_NAME}"

declare -a LOCAL_FILES=(
    "${LOCAL_CFG_PATH}/data/etc/nginx/errors.conf"
    "${LOCAL_CFG_PATH}/data/etc/nginx/sites-available/backend.vhost"
    "${LOCAL_CFG_PATH}/data/etc/nginx/sites-available/backoffice.vhost"
    "${LOCAL_CFG_PATH}/data/etc/nginx/sites-available/public.vhost"
    "${LOCAL_CFG_PATH}/data/ssl/server.crt"
    "${LOCAL_CFG_PATH}/data/ssl/server.key"
    "${LOCAL_CFG_PATH}/etc/nginx/nginx.conf"
    "${LOCAL_CFG_PATH}/etc/yum.repos.d/nginx.repo"
)

_check_files ${LOCAL_NAME} LOCAL_FILES[@]

cp -bfv "${LOCAL_CFG_PATH}/etc/yum.repos.d/nginx.repo" /etc/yum.repos.d/nginx.repo
yum -y install nginx 
chkconfig nginx on

mkdir -p /data/etc/nginx/sites-available \
         /data/etc/nginx/sites-enabled \
         /data/ssl

cp -bfv "${LOCAL_CFG_PATH}/data/etc/nginx/errors.conf" /data/etc/nginx/errors.conf
cp -bfv "${LOCAL_CFG_PATH}/data/etc/nginx/sites-available/backend.vhost" /data/etc/nginx/sites-available/backend.vhost
cp -bfv "${LOCAL_CFG_PATH}/data/etc/nginx/sites-available/backoffice.vhost" /data/etc/nginx/sites-available/backoffice.vhost
cp -bfv "${LOCAL_CFG_PATH}/data/etc/nginx/sites-available/public.vhost" /data/etc/nginx/sites-available/public.vhost
cp -bfv "${LOCAL_CFG_PATH}/data/ssl/server.crt" /data/ssl/server.crt
cp -bfv "${LOCAL_CFG_PATH}/data/ssl/server.key" /data/ssl/server.key
cp -bfv ${LOCAL_CFG_PATH}/etc/nginx/nginx.conf /etc/nginx/nginx.conf

cd /data/etc/nginx/sites-enabled
ln -sf ../sites-available/backend.vhost .
ln -sf ../sites-available/backoffice.vhost .
ln -sf ../sites-available/public.vhost .

echo "127.0.0.1    backend.local" >> /etc/hosts
