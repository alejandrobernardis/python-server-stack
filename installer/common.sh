#!/bin/bash
# Copyright (c) 2014 Asumi Kamikaze Inc.
# Copyright (c) 2014 The Octopus Apps Inc.
# Licensed under the MIT License.
# Author: Alejandro M. Bernardis
# Email: alejandro.bernardis at gmail.com
# Created: 07/03/14 20:50:52

function _title() {
    echo ""
    echo "~"
    echo "** ${1} **"
}

function _title_break() {
    echo ""
    echo "~"
    echo "* ${1}"
}

function _check_files() {
    declare -a files=("${!2}")
    for file in "${files[@]}"
    do
        if [ ! -e ${file} ];
        then
            echo "(e): ~${1}~ File not found: ${file}"
            exit 3
        fi
    done
}

