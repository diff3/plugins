#!/bin/sh
  BASEDIR=`dirname $0`

  if [ "$1" == "start" ]; then
     export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${BASEDIR}/lib
     
     chmod +x ${BASEDIR}/bin/php
     chmod +x ${BASEDIR}/bin/php-cgi
     
     /data/hack/bin/busybox httpd -p 80 -h ${BASEDIR}/www -c /data/plugins/webserver/httpd.conf &
     echo "Webserver started"
  elif [ "$1" == "stop" ]; then
     ID=$(ps aux | grep httpd | grep busybox | grep -v grep | awk '{print $2}')
     kill -9 $ID
    echo "Webserver stopped"
  else
    echo "Webserver: Error!"
  fi
