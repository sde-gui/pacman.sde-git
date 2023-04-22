#!/bin/bash

set -o nounset
set -ex

. ./update_status.sh

MAKEPKG="${MAKEPKG:-makepkg}"
PACMAN="${PACMAN:-pacman}"
SUDO="${SUDO:-sudo}"

pacman_queue() {
    local lockfile=/var/lib/pacman/db.lck
    if [[ -f ${lockfile} ]]; then
        echo 'Pacman is currently in use, waiting...'
        while [[ -f ${lockfile} ]]; do sleep 5; done
    fi
}

run_pacman() {
    pacman_queue
    $SUDO $PACMAN "$@"
}

package="$1"
build_dir="$REPO_BUILD_ROOT/build/$package"

update_status "$package" "PREPARE"

mkdir -p "$REPO_BUILD_ROOT/repo"
test -d "$build_dir" && rm -rf "$build_dir"
mkdir -p "$build_dir"
(cd "$REPO_BUILD_ROOT/recipes/$package" && cp -a -- * "$build_dir")

export MAKEPKG_CONFIGURE_HOOK="$REPO_BUILD_ROOT/makepkg_configure_hook.sh"
export MAKEPKG_BUILD_HOOK="$REPO_BUILD_ROOT/makepkg_build_hook.sh"

(
    cd "$build_dir"

    update_status "$package" "FETCH"
    $MAKEPKG

    update_status "$1" "INSTALL"
    for p in *.pkg.tar.xz ; do
        run_pacman --noconfirm -U "`readlink -f "$p"`"
    done

    update_status "$1" "REPO"
    cp -- *.pkg.tar.xz "$REPO_BUILD_ROOT/repo/"
    touch "$REPO_BUILD_ROOT/repo/.timestamp.build.$1"

    update_status "$1" "DONE"
    sleep 2 && \
    update_status "$1" ""
)
