#!/bin/sh
  BASEDIR=`dirname $0`

  if [ "$1" == "start" ]; then
     export LD_LIBRARY_PATH=${BASEDIR}/lib 

     [ -x "${BASEDIR}/bin/utserver" ] || chmod +x ${BASEDIR}/bin/utserver
     [ -x "${BASEDIR}/bin/ld-linux.so.2" ] || chmod +x ${BASEDIR}/bin/ld-linux.so.2
     [ ! -f "${BASEDIR}/pid/utserver.pid" ] || rm ${BASEDIR}/pid/utserver.pid
     
     ${BASEDIR}/bin/ld-linux.so.2 ${BASEDIR}/bin/utserver -settingspath ${BASEDIR}/settings -configfile ${BASEDIR}/utserver.conf -pidfile ${BASEDIR}/pid/utserver.pid -daemon > ${BASEDIR}/log/server.log &
     echo "uTorrent started"
  elif [ "$1" == "stop" ]; then
     [ ! -f "${BASEDIR}/pid/utserver.pid" ] || kill `cat ${BASEDIR}/pid/utserver.pid`
     [ ! -f "${BASEDIR}/pid/utserver.pid" ] || rm ${BASEDIR}/pid/utserver.pid
     echo "uTorrent stopped"
  else
     echo "uTorrent: Error!"
  fi
