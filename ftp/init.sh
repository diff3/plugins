#!/bin/sh
  BASEDIR=`dirname $0`

  if [ "$1" == "start" ]; then
     sh ${BASEDIR}/ftp.sh &
     echo "Ftpserver started"
  elif [ "$1" == "stop" ]; then
     ID=$(ps aux | grep ftp | grep busybox | grep -v grep | awk '{print $2}')
     kill -9 $ID
    echo "Ftpserver stopped"
  else
    echo "Ftpserver: Error!"
  fi
