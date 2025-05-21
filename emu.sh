#!/bin/sh -e

case `id -u` in 0) ;; *)
  if which doas &> /dev/null; then P="doas"; else P="sudo"; fi ;;
esac

"${P}" su -c "emaint sync -a && emerge -uDN @world --keep-going && emerge -c"
