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
key=$(cat vtapi.txt)
testhash=$(md5sum /mnt/c/Windows/System32/notepad.exe | awk '{print $1}')
#
# Script has a single arguement
#
if [ "$1" = "" ]
then
	echo "[-] Usage $0 /some/directory/with/files/you/want/to/check"
	exit
fi
#
# Create sub-directory in CWD to organize the results
#date
timestamp=$(date +%F)
newdirname=$(echo $1 | sed 's/.$//' | awk -F "/" '{print $NF}')
#echo $newdirname
newdir=$(echo -n $timestamp && echo -n  "-" && echo $newdirname)
echo -n "[-] Creating new directory " && echo $newdir
mkdir $newdir
#exit
#
#
#echo $testhash
#echo $key
#exit
#
# Testing the script
# Change testing to true if you want to test your API key
#
testing=true
while [ $testing = true ]
do
	filename=testfile.txt
	#nmap -v --script http-virustotal --script-args='apikey="$key",checksum="$testhash"'
	curl -s -X POST 'https://www.virustotal.com/vtapi/v2/file/report' --form apikey="$key" --form resource="$testhash" > $filename
testing=false
done
echo "[-] Test API skipped!"
#exit
#
# Use find to get a md5sum for each file, recursively, in the directory listed in arguement 1
#
find $1 -type f > /tmp/vtfilelist.txt
#cat /tmp/vtfilelist.txt
#
# md5sum of every file in the directory
#
for md5loop in $(cat /tmp/vtfilelist.txt)
do
	md5sum $md5loop | awk '{print $1}' >> /tmp/md5list.txt
done
#cat /tmp/md5list.txt
#exit
#
# Now that we have a list of md5's we can iterate through the hashlist with our VT API key
#
for vtloop in $(cat /tmp/md5list.txt)
do
	filename=$newdir/raw_$vtloop.txt
        #nmap -v --script http-virustotal --script-args='apikey="$key",checksum="$testhash"'
        curl -s -X POST 'https://www.virustotal.com/vtapi/v2/file/report' --form apikey="$key" --form resource="$vtloop" > $filename
	positives=$(cat $filename | tr ',' '\n' | grep positive | awk '{print $2}')
	if  [ $positives="" ]
	then
		postives=0
	fi
	echo "$vtloop has $positives positives on VT" | tee -a /tmp/positives.txt
done 
#
# creating a file list of the raw results
#
tmpsweep=$(wc -l /tmp/vtfilelist.txt | awk '{print $1}')
#echo $tmpsweep
#exit
#exit
#
# Remove tmp files
#
/bin/rm /tmp/vtfilelist.txt
/bin/rm /tmp/md5list.txt
/bin/rm /tmp/positives.txt
