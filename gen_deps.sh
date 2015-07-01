#!/bin/bash

set -e
#set -x

PACKAGES="`ls */PKGBUILD | grep -o '^[^/]*'`"

printf "PACKAGES = %s\n" "`echo $PACKAGES`"

for p in $PACKAGES ; do
    unset -v depends
    unset -v makedepends
    eval "`egrep '^depends=\(.*\)' "$p/PKGBUILD"`"
    eval "`egrep '^makedepends=\(.*\)' "$p/PKGBUILD"`"
    for dep in "${depends[@]}" "${makedepends[@]}" ; do
        for p1 in $PACKAGES ; do
            if [ "$dep" = "$p1" ] ; then
                printf '$(P)%s : $(P)%s\n' "$p" "$dep"
            fi
        done
    done
done