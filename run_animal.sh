#!/bin/sh
# 
# This script is intended to run from cron 
# It performs some environment configuration, checks for
# load and runs run_branches
#
# If --host is passed as arg, it checks for load on local host
# Otherwise it assumes that it runs on virutal machine or container
# and checks for load on default gateway.
# 

cd `dirname $0`
RBARGS="--run-all"
CLARGS=""
for a ; do
	case "$a" in
	--host)
		CLARGS="$CLARGS $a"
		;;
	*)
		RBARGS="$RBARGS $a"
		;;
	esac
done
./checkload.sh ${CLARGS}|| exit 
PERL5LIB=`pwd`
ulimit -c unlimited
./run_branches.pl ${RBARGS}


