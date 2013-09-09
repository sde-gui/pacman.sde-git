#!/bin/bash

set -e
set -x

mkdir -p repo
cd ./$1 && rm -fr *.xz src/ && makepkg -o && touch ../repo/.timestamp.prepare.$1
