#!/bin/bash

set -e
set -x

mkdir -p repo
cd ./$1 && rm -f *.xz && makepkg -o && touch ../repo/.timestamp.prepare.$1
