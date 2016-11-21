#!/bin/bash

#	This script checks the MAC and IP addresses associated to local machines and sees if, after some seconds,  these
# have changed. 
# This script was written for my exam of Bash at the university.

declare -i wait=2 #If not set, as default the script waits 2 seconds between the two checks

while getopts ":t:" opt; do
	case $opt in
		t ) wait=${OPTARG:=2} ;; #Sets the time specified by the user
		\? ) echo 'usage: ./esame102 [-t args] '
		exit 1
	esac
done

shift $(($OPTIND -1))

trap 'echo Script executed. Bye bye!' EXIT

arp -a | awk '{print $2 " " $4}' | tr -d '()' > ip-mac #Gets the IP and MAC addresses and saves them in a file in the current directory

sleep $wait #zZzZz

arp -a | awk '{print $2 " " $4}' | tr -d '()' > ip-mac$wait #Does again the same thing, this time in another file

trap 'rm -rf ip-mac ip-mac$wait; exit' INT TERM #Since two files have been created, if the program gets inturrepted these two files are removed

if [[ $(comm -13 ip-mac ip-mac$wait) ]]; then
	echo These IPs and Mac Adesseses have changed: #If the command 'comm' was correctly executed, then the differences are printed
	comm -13 ip-mac ip-mac$wait
	echo
else
	echo Nothing has changed.
	echo
fi

rm -rf ip-mac ip-mac$wait #Created files are removed
