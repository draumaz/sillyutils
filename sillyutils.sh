#!/bin/bash -e

emu() {
  case `id -u` in 0) ;; *)
    if which doas &> /dev/null; then P="doas"; else P="sudo"; fi ;;
  esac
  "${P}" su -c "emaint sync -a && emerge -uDN @world --keep-going && emerge -c"
}

corntab() {
  sp="/-\|"
  case $1 in -e) xdg-open https://www.youtube.com/watch?v=X0YLt4dcx8w; exit 0 ;; esac
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
  while true; do
    case "${1}" in "")
      CURRENT="$(find /var/log/portage -printf '%TY-%Tm-%TdT%TT %p\n') | sort | tail -1 | awk '{print $2}')"
      *) CURRENT="*${1}*" ;;
    esac
    tail -f /var/log/portage/${CURRENT} || sudo tail -f /var/log/portage/${CURRENT} | while IFS= read -r LINE; do
      echo "${LINE}"
      case "${LINE}" in *"Final size of installed tree"*)
        sleep 5
        break
      ;;
      esac
    done
  done
}

loop_despook() {
  while ps aux | grep -i "[M]icrosoftEdgeUpdate" > /dev/null 2>&1; do
    kill `ps aux | grep -i "[M]icrosoftEdgeUpdate" | awk '{print $2}'`
    echo "found and killed."
  done
}

dbus_plasma_wayland_session() { exec dbus-run-session startplasma-wayland; }
rain_noise() { mpv https://www.youtube.com/watch?v=b8w6ma9gfys --no-video --really-quiet; }

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
