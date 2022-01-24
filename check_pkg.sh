#!/bin/bash

if [ ! -f $1 ]; then
	echo "No such file:[ $1 ]"
	exit 0
else
	echo "file:[ $1 ] is ok"
	exit 1
fi
