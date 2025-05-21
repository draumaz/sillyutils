#!/bin/sh -e

case ${URL} in
  "") URL="${1}" ;;
esac

curl -sL ${URL} | grep 'watch?v' | \
  tr '"' '\n' | grep 'youtube.com/watch?v' | \
    tee -a ./videos.txt
