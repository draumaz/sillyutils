#!/bin/sh

set -x

mkdir -p bin
cd bin

for LINK in `cat ../sillyutils.sh | \
  tr ' ' '\n' | \
  grep '()' | \
  tr '()' '\n' | \
  grep '[Aa-zZ]'`; do
    ln -sv sillyutils "${LINK}"
done
