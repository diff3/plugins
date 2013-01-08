#!/bin/sh
  BASEDIR=`dirname $0`

  if [ "$1" == "start" ]; then
     if [ ! -d "${BASEDIR}/var" ]; then
	cp -r /var ${BASEDIR}
	mkdir ${BASEDIR}/var/spool
	mkdir ${BASEDIR}/var/spool/cron
	mkdir ${BASEDIR}/var/spool/cron/crontabs
     fi
     
     chmod +x ${BASEDIR}/bin/crontab
     
     mount -o bind ${BASEDIR}/var /var
     # echo '* * * * * echo "Working" >> ${BASEDIR}/hello.txt' >> /var/spool/cron/crontabs/root
  
     /data/hack/bin/busybox crond &
     echo "Crond: started"
  elif [ "$1" == "stop" ]; then
     ID=$(ps aux | grep crond | grep busybox | grep -v grep | awk '{print $2}')
     [ ! $ID ] || kill -9 $ID
     echo "Crond: stopped"
  else
     echo "Crond: Error!"
  fi

