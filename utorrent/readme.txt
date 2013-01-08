uTorrent Server alpha (3.0 build 27079)
---------------------------------------

default login name and password is: admin

you can access utorrent client site with a web browser [boxee-ip]:1050\gui

utorrent.conf is a default file from uTorrent forums, but you can
change all configuration from the gui page. If you need to reset to
default again telnet to boxee box and run

rm /data/plugins/utorrent/settings/*

and reload utorrent with 
sh init stop
sh init start

or reboot boxee box 
