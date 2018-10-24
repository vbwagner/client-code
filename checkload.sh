#!/bin/sh
# Gets info about host's load from getload script running on default
# gateway via http
# If --host is passed, checks for load of localhost. (Use that when
# running some jobs on host where several VMs are also running and
# compete for CPU).
# if --only is passed, just exits successfully. Use this for hardware
# nodes where there is no other load.
if [ "$1" = "--only" ]; then
	exit 0
fi
if [ "$1" = "--host" ]; then
	gateway=localhost
else	
	case `uname -s` in
	Linux)
		PATH=/usr/bin:/usr/sbin:/bin:/sbin
		gateway=`ip route show|awk '$1=="default" {print $3;}'`
		;;
	*) 
		gateway=`/sbin/route get default|awk '$1=="gateway:" {print $2}'`
		;;
	esac
fi
test "`curl http://$gateway:8000 2>/dev/null`" = "OK" 


