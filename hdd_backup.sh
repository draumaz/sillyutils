#!/bin/sh -e

DATE="$(date -I)"

case ${1} in
  dots|"")
    case $1 in --include-repos) XTRA="remote-repos" ;; *) ;; esac
    FILE="$HOME/dots-${DATE}-${HOSTNAME}.tar"
    cd ${HOME}
    tar -cvf ${FILE} \
      .git* \
      .hidden* \
      .ssh* \
      ${XTRA}
  ;;
  storage)
    FILE="/mnt/storage/storage-${DATE}-${HOSTNAME}.tar"
    cd /mnt/storage
    tar -cvf ${FILE} \
      misc \
      music \
      photos \
      unix \
      videos \
      vpn
  ;;
esac

du -sh "${FILE}"
