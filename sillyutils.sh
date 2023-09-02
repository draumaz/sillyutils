#!/bin/bash -e
##
## sillyutils, by draumaz (1.1)
##

corntab() {
  sp="/-\|"
  case $1 in -e) google-chrome-stable https://www.youtube.com/watch?v=X0YLt4dcx8w; exit 0 ;; esac
  clear; cat << EOF
=================
corntab
by draumaz
=================
EOF
  read; clear
}

hdd_backup() {
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
}

fastpush() {
  case "${1}" in '') exit 1 ;; *) cd "${1}" ;; esac
  git add *; git commit -m "${2}"; git push
}

tbc() {
  case ${URL} in "") URL="${1}" ;; esac 
  curl -sL ${URL} | grep 'watch?v' | \
    tr '"' '\n' | grep 'youtube.com/watch?v' | tee -a ./videos.txt
}

glog() {
  case "${1}" in "")
    CURRENT="`ls --color=no /var/log/portage -tr | tail -1`" ;;
    *) CURRENT="*${1}*" ;;
  esac
  tail -f /var/log/portage/${CURRENT} || sudo tail -f /var/log/portage/${CURRENT}
}

loop_despook() {
  while ps aux | grep -i "[M]icrosoftEdgeUpdate" > /dev/null 2>&1; do
    kill `ps aux | grep -i "[M]icrosoftEdgeUpdate" | awk '{print $2}'`
    echo "found and killed."
  done
}

dbus_plasma_wayland_session() { exec dbus-run-session startplasma-wayland; }

LAUNCHER="$(echo ${0} | tr '/' '\n' | tail -1)"

case "${LAUNCHER}" in
  *sillyutils*)
    if test -e ./sillyutils.1; then
      man ./sillyutils.1
    else
      man sillyutils
    fi
    exit 0
  ;;
  *) "${LAUNCHER}" "${@}" ;;
esac
