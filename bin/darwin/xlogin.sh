#!/usr/bin/env bash

#
# Login into a remote machine using XDM
#

if [ "$1" = "" ]; then
	echo "usage: $0 host"
	exit
fi

X -indirect $1 -terminate
