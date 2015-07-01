#!/bin/bash

set -e
set -x

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
cd ./$1 && rm -fr *.xz src/ && makepkg && _pacman --noconfirm -U `readlink -f *.xz` && cp *.xz ../repo/ && touch ../repo/.timestamp.build.$1
