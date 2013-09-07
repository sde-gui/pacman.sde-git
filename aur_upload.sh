#!/bin/bash

set -e
set -x

find . -maxdepth 2 -name 'PKGBUILD' -printf '%h\n' | while read dir ; do
    (cd $dir && rm -f *.src.tar.gz && makepkg --source && burp -c x11 *.src.tar.gz)
done
