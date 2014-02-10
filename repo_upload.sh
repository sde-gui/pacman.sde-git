#!/bin/bash

set -e
set -x

if [[ -z $1 ]] ; then
    echo "no address" > /dev/stderr
    exit -1
fi

rsync -rlt --delete-after --progress repo/ "$1:/srv-jail/data/repos/archlinux/sde-nightly/`uname -m`/"
