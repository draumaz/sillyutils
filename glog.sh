#!/bin/sh -e

while true; do
  case "${1}" in "")
      CURRENT="$(find /var/log/portage -printf '%TY-%Tm-%TdT%TT %p\n' | sort | tail -1 | awk '{print $2}')" ;;
      *) CURRENT="*${1}*" ;;
  esac

  tail -f ${CURRENT} || sudo tail -f ${CURRENT} | \
    while IFS= read -r LINE; do
      echo "${LINE}"
      case "${LINE}" in *"Final size of installed tree"*)
        break
      ;;
      esac
      sleep 5
    done
done
