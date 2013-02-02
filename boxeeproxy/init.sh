#!/bin/sh
  BASEDIR=`dirname $0`

  if [ "$1" == "start" ]; then
     chmod +x ${BASEDIR}/bin/bplin
     
     ${BASEDIR}/bin/bplin &
     echo "Proxy started"
  elif [ "$1" == "stop" ]; then
     ID=$(ps aux | grep bplin | grep -v grep | awk '{print $2}')
     kill -9 $ID
    echo "Proxy stopped"
  else
    echo "Proxy: Error!"
  fi
