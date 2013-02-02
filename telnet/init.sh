#!/bin/sh
  BASEDIR=`dirname $0`

  if [ "$1" == "start" ]; then
     sh ${BASEDIR}/telnet.sh &
     echo "Telnet server started"
  elif [ "$1" == "stop" ]; then
     ID=$(ps aux | grep telnet | grep busybox | grep -v grep | awk '{print $2}')
     kill -9 $ID
    echo "Telnet server stopped"
  else
    echo "Telnet server: Error!"
  fi
