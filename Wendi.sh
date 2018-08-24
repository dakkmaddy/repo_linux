#!/bin/bash
#
# Webenator
#
clear
echo "Welcome to Wendi"
echo "Web"
echo "ENumeration"
echo "Discovery"
echo "Integrator"
echo
correct="N"
echo 
while [ $correct = "N" ];
do
echo "Enter your target name. This will be used to create a directory and filenames."
read target
echo
echo "Enter the target IP address"
read ip
echo
echo "Enter a port."
read port
echo
echo "Here is the target information"
echo
echo $target
echo $ip
echo $port
echo
echo "Is this correct (Y/N). The only way to change these values is to enter captial N"
read correct
date | tee time.txt
done
clear
echo "Creating directory...."
sleep 2
mkdir /home/dakkmaddy/$target
cd /home/dakkmaddy/$target
echo
echo "Creating socket variable..."
sleep .5
echo -n $ip > socket.txt
echo -n ":" >> socket.txt
echo -n $port >> socket.txt
socket=`cat socket.txt`
rm socket.txt
echo
echo "Starting nikto scan..."
echo "Will do doing nikto -h <ip address><port> -c=All"
nikto -C=all -h $socket | tee nikto.txt
echo
echo "Nikto complete, on to dirb"
echo
dirb http://$socket /usr/share/dirb/wordlists/common.txt | tee dirbcommon.txt
echo
echo "dirb complete, common, onto unicorn"
echo 
echo "Uniscan"
echo 
uniscan -u $ip -esqdw
echo
echo "Uniscan complete"
echo 
cp /usr/share/uniscan/report/$ip.html uniscan.html
echo
# Skip Fish Scanning
#echo
#skipfish -m 5 -d 5 -o /home/dakkmaddy/$target/Skipfish/ -S /usr/share/skipfish/dictionaries/complete.wl -k 1:00:00 -u http://$target
echo
echo "End of script"
echo "Results are in :"
ls
date | tee -a time.txt
rm time.txt
exit

