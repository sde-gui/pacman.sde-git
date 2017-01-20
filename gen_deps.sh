#!/bin/bash

set -e
#set -x

PACKAGES="`(cd recipes && ls */PKGBUILD | grep -o '^[^/]*')`"

printf "PACKAGES = %s\n" "`echo $PACKAGES`"

for p in $PACKAGES ; do
    unset -v depends
    unset -v makedepends
    eval "`grep -Ezo '[[:space:]]depends=\([^)]*\)' "recipes/$p/PKGBUILD"`"
    eval "`grep -Ezo '[[:space:]]makedepends=\([^)]*\)' "recipes/$p/PKGBUILD"`"
    for dep in "${depends[@]}" "${makedepends[@]}" ; do
        for p1 in $PACKAGES ; do
            if [ "$dep" = "$p1" ] ; then
                printf '$(P)%s : $(P)%s\n' "$p" "$dep"
            fi
        done
    done

    for f in `find "recipes/$p" -type f` ; do
        printf '$(P)%s : %s\n' "$p" "$f"
        printf 'Makefile.deps : %s\n' "$f"
    done
done

