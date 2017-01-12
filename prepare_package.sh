#!/bin/bash

set -o nounset
set -ex

MAKEPKG="${MAKEPKG:-makepkg}"

mkdir -p repo
cd ./$1 && rm -fr *.xz src/ && $MAKEPKG -o && touch ../repo/.timestamp.prepare.$1
