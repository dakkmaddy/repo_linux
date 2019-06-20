#!/bin/sh
#
# Virus Total API check
# 
# Check if vtapi.txt is in the user's current working directory
#
if [ ! -f vtapi.txt ]; then
	echo "[-] This script expects the file vtapi.txt in the CWD."
	echo "[-] If you do not have such a file, you will need to register with the Virus Total Community"
	echo "[-] If you do have this file, please copy it as vtapi.txt in the directory"
	exit   
fi
echo "[-] API key found!"
#
# make the API key a variable
#
key=$(cat vtapi.txt)
#
# Script has a single arguement
#
if [ "$1" = "" ]
then
	echo "[-] Usage $0 /some/files/with/hashes/you/want/to/check, one hash per line"
	exit
fi
#exit
#
#
# Iterate through filelist (your list list) with our VT API key
#
for vtloop in $(cat $1)
do
	curl -s -X POST 'https://www.virustotal.com/vtapi/v2/file/report' --form apikey="$key" --form resource="$vtloop" > /tmp/vtcheck.txt
	positives=$(cat /tmp/vtcheck.txt | tr ',' '\n' | grep positive | awk '{print $2}')
	if  [ -z "$positives" ]
	then
		positives="0"
	fi
	echo "$vtloop has $positives positives on VT"
done
#
# Quick cleanup and exit
#
/bin/rm /tmp/vtcheck.txt
exit
