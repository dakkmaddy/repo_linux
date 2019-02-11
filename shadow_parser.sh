#!/bin/bash
#
# Simple Shell Script to parse the primates from the service accounts on a Shadow file
#
clear
#
# First, we will parse the shadow file for real accounts and users using cat/grep/grep/cut
# Assign as variable "humans"
#
echo "[+] Reading shadow file ..."
humans=$(cat /etc/shadow | grep -v "!" | grep -v "*" | cut -d':' -f1)
echo
sleep .5
#
# General announcements
#
echo -n "[+] This machine has the following human (including root) accounts) " && echo $humans
echo
echo "[+] Let's see how long it has been since they changed their password ... "
sleep .5
#
# Define the date 
#
rightnow=$(expr $(date +%s) / 86400)
echo -n "[+] Current Unix date is .. " && echo $rightnow
#
# We can use the a modified cat/grep/cut, and a different field, and in a loop
# To measure how old the password are
#
for x in $humans
do
	lastchange=$(cat /etc/shadow | grep $x | cut -d':' -f3)
	daysold=$(( $rightnow - $lastchange ))
	echo -n "[+]  " && echo -n $x && echo -n " password is " && echo -n $daysold && echo " days old"
done
