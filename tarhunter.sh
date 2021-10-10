#!/bin/bash
#
clear
current=$(pwd)
rightnow=$(date +%F)
filename=$(echo "tarhunter_$rightnow")
echo "[-] Creating a file list starting from the $current directory"
find . -type f > /tmp/$filename
echo
sleep 2
echo "[-] Temporary file created!"
cat /tmp/$filename
echo
echo "[-] Will use array to find possible users and credentials"
echo
for loop1 in $(cat /tmp/$filename)
do
	for loop2 in user pass cred key hash secret
	do
		finder=$(cat $loop1 | grep -c $loop2)
		if [ $finder = "0" ];
		then
			echo -n "."
		else
			echo "[-] Keyword $loop2 found in $loop1" | tee -a results.log
			echo -n "---> " >> results.log
			cat $loop1 | grep $loop2 >> results.log
			echo "[-] Added to results.log"
		fi
	done
done
echo 
echo "[-] Analysis complete! removing unnecessary files"
/bin/rm -rf /tmp/$filename
exit

