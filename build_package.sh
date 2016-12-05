#!/bin/bash

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

mkdir -p repo

export MAKEPKG_BUILD_HOOK="$REPO_BUILD_ROOT/makepkg_build_hook.sh"

cd ./$1 && \
    rm -fr *.xz src/ && \
    update_status "$1" "F" && \
    makepkg && \
    update_status "$1" "U" && \
    _pacman --noconfirm -U `readlink -f *.xz` && \
    update_status "$1" "R" && \
    cp *.xz ../repo/ && \
    touch ../repo/.timestamp.build.$1 && \
    update_status "$1" "D" && \
    sleep 2 && \
    update_status "$1" ""
