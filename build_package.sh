#!/bin/bash

set -o nounset
set -e
set -x

. ./update_status.sh

pacman_queue() {
    local lockfile=/var/lib/pacman/db.lck
    if [[ -f ${lockfile} ]]; then
        echo 'Pacman is currently in use, waiting...'
        while [[ -f ${lockfile} ]]; do sleep 5; done
    fi
}

_pacman() {
    pacman_queue
    sudo pacman "$@"
}

package="$1"
build_dir="$REPO_BUILD_ROOT/build/$package"

update_status "$package" "P" # Prepare

mkdir -p "$REPO_BUILD_ROOT/repo"
test -d "$build_dir" && rm -rf "$build_dir"
mkdir -p "$build_dir"
(cd "$REPO_BUILD_ROOT/$package" && cp -a -- * "$build_dir")

export MAKEPKG_BUILD_HOOK="$REPO_BUILD_ROOT/makepkg_build_hook.sh"

(
    cd "$build_dir"

    update_status "$package" "F" # Fetch
    makepkg

    update_status "$1" "U" # Upgrade
    for p in *.pkg.tar.xz ; do
        _pacman --noconfirm -U "`readlink -f "$p"`"
    done

    update_status "$1" "R" # add to Repo
    cp -- *.pkg.tar.xz "$REPO_BUILD_ROOT/repo/"
    touch "$REPO_BUILD_ROOT/repo/.timestamp.build.$1"

    update_status "$1" "D" # Done
    sleep 2 && \
    update_status "$1" ""
)
