#!/bin/sh

set -x

mkdir ./bin ./doc

cp ./sillyutils.sh bin/sillyutils
cp ./sillyutils.1 doc/sillyutils.1

chmod +x bin/sillyutils

for LINK in `cat ./sillyutils.sh | \
  tr ' ' '\n' | \
  grep '()' | \
  tr '()' '\n' | \
  grep '[Aa-zZ]'`; do
    cd ./bin; ln -s sillyutils "${LINK}"; cd ..
    cd ./doc; ln -s sillyutils.1 "${LINK}.1"; cd ..
done
