#!/bin/bash

set -e
set -x

build()
{
    (cd $1 && rm -f *.xz && makepkg && yaourt -U *.xz)
}

build libsmfm-core-git
build libsmfm-gtk2-git
build libsde-utils-git
build libsde-utils-gtk2-git
build libsde-utils-jansson-git
build stuurman-git
build stuurman-desktop-git
build waterline-git
