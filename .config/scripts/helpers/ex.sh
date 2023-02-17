#!/bin/bash

ex ()
{
  if [ -f "$@" ] ; then
    case "$@" in
      *.tar.bz2)   tar xjf "$@"   ;;
      *.tar.gz)    tar xzf "$@"   ;;
      *.bz2)       bunzip2 "$@"   ;;
      *.rar)       unrar x "$@"   ;;
      *.gz)        gunzip "$@"    ;;
      *.tar)       tar xf "$@"    ;;
      *.tbz2)      tar xjf "$@"   ;;
      *.tgz)       tar xzf "$@"   ;;
      *.zip)       unzip "$@"     ;;
      *.Z)         uncompress "$@";;
      *.7z)        7z x "$@"      ;;
      *.deb)       ar x "$@"      ;;
      *.tar.xz)    tar xf "$@"    ;;
      *.tar.zst)   unzstd "$@"    ;;
      *)           echo "'"$@"' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$@' is not a valid file"
  fi
}

ex "$@"
