#!/bin/sh

mkdir -pv bin; cd bin

for LINK in `cat ../sillyutils.sh | \
  tr ' ' '\n' | \
  grep '()' | \
  tr '()' '\n' | \
  grep '[Aa-zZ]'`; do
    ln -sv sillyutils "${LINK}"
done
