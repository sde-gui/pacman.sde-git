#!/bin/bash

set -e
set -x

mkdir -p repo
cd ./$1 && rm -f *.xz && makepkg && sudo yaourt --noconfirm -U `readlink -f *.xz` && cp *.xz ../repo/ && touch ../repo/.timestamp.build.$1
