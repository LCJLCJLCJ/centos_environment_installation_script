#!/bin/bash

# echo "firewall-cmd --zone=public --add-port=80/tcp --permanent"

# echo `firewall-cmd --reload`

# echo `firewall-cmd --zone=public --list-ports`

port=$1
if [ -z "$1" ]; then
	echo "Please enter port:"
	read port null
fi
firewall-cmd --zone=public --add-port=$port/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=public --list-ports