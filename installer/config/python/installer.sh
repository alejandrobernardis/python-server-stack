#!/bin/bash
# Copyright (c) 2014 Asumi Kamikaze Inc.
# Copyright (c) 2014 The Octopus Apps Inc.
# Licensed under the MIT License.
# Author: Alejandro M. Bernardis
# Email: alejandro.bernardis at gmail.com
# Created: 07/03/14 21:04:34

_title "PYTHON"

LOCAL_NAME="python"
LOCAL_CFG_PATH="${CFG_PATH}/${LOCAL_NAME}"

declare -a LOCAL_FILES=(
    "${LOCAL_CFG_PATH}/tmp/requirements.txt"
)

_check_files ${LOCAL_NAME} LOCAL_FILES[@]

cd ${DOWNLOAD_PATH}
curl -O https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz
tar xfvz Python-2.7.8.tgz

cd Python-2.7.8
./configure \
    --prefix=/usr/local \
    --enable-unicode=ucs4 \
    --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
make && make altinstall

cd ${DOWNLOAD_PATH}
curl -O https://pypi.python.org/packages/source/s/setuptools/setuptools-5.3.tar.gz
tar xfvz setuptools-5.3.tar.gz

cd setuptools-5.3
python2.7 setup.py build
python2.7 setup.py install

easy_install pip

pip install -r "${LOCAL_CFG_PATH}/tmp/requirements.txt"