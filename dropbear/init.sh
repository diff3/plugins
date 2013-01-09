#!/bin/sh
CONFDIR=/etc/dropbear
BASEDIR=`dirname $0`

if [ "$1" == "start" ]; then
  mount -o bind ${BASEDIR}/etc-hack /etc

  # Copy /etc to make it writable
  
  if [ ! -d "${BASEDIR}/etc-hack" ]; then
    cp -ar /etc ${BASEDIR}/etc-hack
    cp -ar ${BASEDIR}/etc-basic/* ${BASEDIR}/etc-hack

    # vpn fixes from network.sh
    chmod +x ${BASEDIR}/etc-hack/ppp/* 
  fi
            
  # fix possibly broken dropbear links

  [ -L ${BASEDIR}/bin/dropbearkey ] || ln -s dropbearmulti ${BASEDIR}/bin/dropbearkey
  [ -L ${BASEDIR}/bin/dropbear ] || ln -s dropbearmulti ${BASEDIR}/bin/dropbear
  [ -L ${BASEDIR}/bin/dbclient ] || ln -s dropbearmulti ${BASEDIR}/bin/dbclient
  [ -L ${BASEDIR}/bin/scp ] || ln -s dropbearmulti ${BASEDIR}/bin/scp
  [ -L ${BASEDIR}/bin/passwd ] || ln -s /data/hack/bin/busybox ${BASEDIR}/bin/passwd
  [ -x ${BASEDIR}/bin/dropbearmulti ] || chmod +x ${BASEDIR}/bin/dropbearmulti

  # creat keys if needed

  [ -d ${BASEDIR}/home/root ] || mkdir -m 0755 ${BASEDIR}/home
  [ -d ${BASEDIR}/home/root ] || mkdir -m 0755 ${BASEDIR}/home/root
  [ -d ${CONFDIR} ] || mkdir -p ${CONFDIR};
  [ -f ${CONFDIR}/dropbear_rsa_host_key ] || dropbearkey -t rsa -f ${CONFDIR}/dropbear_rsa_host_key
  [ -f ${CONFDIR}/dropbear_dss_host_key ] || dropbearkey -t dss -f ${CONFDIR}/dropbear_dss_host_key

  ${BASEDIR}/bin/dropbear &
  echo "dropbear started"
elif [ "$1" == "stop" ]; then
  ID=$(ps aux | grep dropbear | grep -v grep | awk '{print $2}')
  [ ! $ID ] || kill -9 $ID
  echo "dropbear stopped"
else
  echo "dropbear: Error!"
fi
