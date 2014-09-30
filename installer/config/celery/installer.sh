#!/bin/bash
# Copyright (c) 2014 Asumi Kamikaze Inc.
# Copyright (c) 2014 The Octopus Apps Inc.
# Licensed under the MIT License.
# Author: Alejandro M. Bernardis
# Email: alejandro.bernardis at gmail.com
# Created: 07/03/14 21:04:34

_title "CELERY"

groupadd -r celeryd

useradd -M -r -g celeryd \
        -G www \
        -d /var/lib/celeryd \
        -s /bin/false \
        -c "Celery" celeryd > /dev/null 2>&1
