#!/bin/sh

set -x

mkdir ./bin; cd ./bin

cp ../sillyutils.sh ./sillyutils
chmod +x ./sillyutils

for LINK in `cat ../sillyutils.sh | \
  tr ' ' '\n' | \
  grep '()' | \
  tr '()' '\n' | \
  grep '[Aa-zZ]'`; do
    ln -s sillyutils "${LINK}"
done
