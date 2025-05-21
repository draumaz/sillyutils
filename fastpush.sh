#!/bin/sh -e

case "${1}" in
  '') exit 1 ;;
  *) cd "${1}" ;;
esac

git add *
git commit -m "${2}"
git push
