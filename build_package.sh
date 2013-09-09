#!/bin/bash

set -e
set -x

cd ./$1 && rm -f *.xz && makepkg && yaourt -U *.xz && cp *.xz ../ready/ && touch ../ready/.timestamp.$1
