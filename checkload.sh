#!/bin/sh
# Gets info about host's load from getload script running on default
# gateway via http
if [ "$1" = "--host" ]; then
	gateway=localhost
else	
	case `uname -s` in
	Linux)
		gateway=`ip route show|awk '$1=="default" {print $3;}'`
		;;
	*) 
		gateway=`/sbin/route get default|awk '$1=="gateway:" {print $2}'`
		;;
	esac
fi
test "`curl http://$gateway:8000 2>/dev/null`" = "OK" 


