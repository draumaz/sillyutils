#!/bin/bash -e
##
## sillyutils, by draumaz (1.1)
##

oae() {
  MACPAC_REPO="https://oooa.draumaz.xyz/app" MACPAC_INSTALL_PATH="/Applications" \
    macpac "${@}"
}  

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

macpac_index_regenerate() {

  WORKING="/var/oooa/bin"
  cd "${WORKING}"
  
  rm -f ./index.html
  case $1 in no-pre)echo ok;;*)
  cat >> index.html << EOF
<html lang="en">
  
  <head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css"">
	<title>opt-out-of-air/news</title>
  </head>
  
  <main class="container">
    <hgroup>
      <hgroup>
        <h2>opt-out-of-air/bin</h2>
        <h3><a href="/">home</a> · <a href="/news">news</a> · bin</h3>
      </hgroup> <br>
    
EOF
  ;; esac
  for PKG in $(find * -name "*.tar.gz" | sort); do
    cat >> index.html << EOF
      <a href="https://oooa.draumaz.xyz/bin/${PKG}">${PKG}</a> <br>
EOF
    echo "<a href=https://oooa.draumaz.xyz/bin/${PKG}>${PKG}</a> <br>"; done

    cat >> index.html << EOF
    </hgroup>
  </main>
</html>
EOF

}

hdd_backup() {
  DATE=`date -I`
  case ${1} in dots)
    case $1 in --include-repos) XTRA="remote-repos" ;; *) ;; esac
    FILE="$HOME/dots-${DATE}-${HOSTNAME}.tar"
    cd ${HOME}
    tar -cvf ${FILE} \
      .git* \
      .hidden* \
      .ssh* \
      ${XTRA}
 ;; storage)
	  FILE="/mnt/storage/storage-${DATE}-${HOSTNAME}.tar"
	  cd /mnt/storage
	  tar -cvf ${FILE} \
		misc \
		music \
		photos \
		unix \
		videos \
		vpn
  ;; esac
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
case "${LAUNCHER}" in *sillyutils*) exit 0 ;; *) "${LAUNCHER}" "${@}" ;; esac
