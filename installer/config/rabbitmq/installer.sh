#!/bin/bash
# Copyright (c) 2014 Asumi Kamikaze Inc.
# Copyright (c) 2014 The Octopus Apps Inc.
# Licensed under the MIT License.
# Author: Alejandro M. Bernardis
# Email: alejandro.bernardis at gmail.com
# Created: 07/03/14 21:04:34

_title "RABBITMQ"

cd ${DOWNLOAD_PATH}
curl -O http://www.rabbitmq.com/releases/rabbitmq-server/v3.3.4/rabbitmq-server-3.3.4-1.noarch.rpm
rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
yum -y install rabbitmq-server-3.3.4-1.noarch.rpm

rabbitmq-plugins enable rabbitmq_management
chkconfig rabbitmq-server on
service rabbitmq-server start

rabbitmqctl add_user celery password
rabbitmqctl set_permissions -p / celery ".*" ".*" ".*"

service rabbitmq-server stop
