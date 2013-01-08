#!/bin/sh
clear
let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

DTOOL_BIN=/opt/local/bin/dtool
BX_CPUTMP="`${DTOOL_BIN} 2`"
BX_FANSPD="`${DTOOL_BIN} 3`"

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "+-----------------------------------------------------+
|               Welcome to Boxee+Hacks                |
+-----------------------------------------------------+

`date +"%A, %e %B %Y, %r"`
`uname -srm`

Uptime.............: ${UPTIME}
IP Addresses.......: `/sbin/ifconfig eth0 | /bin/grep "inet addr" | /usr/bin/cut -d ":" -f 2 | /usr/bin/cut -d " " -f 1` and `wget -q -O - http://icanhazip.com/ | tail`
Memory.............: `cat /proc/meminfo | grep MemFree | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total)
Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
Running Processes..: `ps ax | wc -l | tr -d " "`
CPU temp...........: ${BX_CPUTMP} c
FAN speed..........: ${BX_FANSPD} rpm
"
