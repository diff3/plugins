#!/bin/sh
  BASEDIR=`dirname $0`

  if [ "$1" == "start" ]; then
     export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${BASEDIR}/lib
     
     chmod +x ${BASEDIR}/bin/minidlna 
     ${BASEDIR}/bin/minidlna -R -f ${BASEDIR}/minidlna.conf > ${BASEDIR}/minidlna.log 2> /dev/null
     
     echo "minidlna started"
  elif [ "$1" == "stop" ]; then
     ID=$(ps aux | grep minidlna | grep -v grep | awk '{print $2}')
     kill -9 $ID
    echo "minidlna stopped"
  else
    echo "minidlna: Error!"
  fi
