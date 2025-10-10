#!/bin/bash

: "${REAL_PACMAN:=pacman}"
: "${PACMAN_CONF:=pacman-conf}"
: "${FLOCK:=flock}"

pacman_queue() {
    local lockfile="$($PACMAN_CONF DBPath)/db.lck"
    local lockfile=/var/lib/pacman/db.lck
    if [[ -f ${lockfile} ]]; then
        echo 'Pacman is currently in use, waiting...'
        while [[ -f ${lockfile} ]]; do sleep 5; done
    fi
}

if command -v "$FLOCK" 1>/dev/null 2>&1 ; then
    lockfile="$REPO_ROOT/tmp/pacman.lck"
    pacman_queue
    flock $lockfile $REAL_PACMAN "$@"
else
    echo "Warning $FLOCK not installed"
    pacman_queue
    $REAL_PACMAN "$@"
fi
