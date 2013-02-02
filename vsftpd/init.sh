#!/bin/sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/plugins/vsftpd/lib

# /data/plugins/vsftpd/bin/ld-linux.so.2 /data/plugins/vsftpd/bin/vsftpd /data/plugins/vsftpd/vsftpd.conf -oftpd_banner=blah 
/data/plugins/vsftpd/bin/vsftpd /data/plugins/vsftpd/vsftpd.conf -oftpd_banner=blah 
