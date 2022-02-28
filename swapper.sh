#!/bin/bash
#
# Determine if there is space on the disk
space=$(df -h | grep -v tmp | grep -v udev | head -n 2 | tail -n 1 | awk '{print $4}' | sed 's/G//')
#
if [[ $space -lt 8 ]];
then
	echo "[-] You have less than 8GB of space, exiting"
	exit 1
else
	echo "[-] Sufficient space on the main disk, proceeding"
fi
# Determine amount of memory in Megabytes
#
totmem=$(free -m | grep "Mem:" | awk '{print $2}')
#
# Use an if then elif fi loop to get a measurement estimate
#
if [[ $totmem < 1000 ]];
then
	echo "[-] You have less than 1GB of memory, you should not do any swap"
	exit 1
elif [[ $totmem < 2000 ]]; 
then
	echo "[-] This node has between 1GB and 3GB of memory swap set to 2G"
	swsz="2G"
else
	echo "[-] This node has over 3GB of memory - Swap set to 4G"
	swsz="4G"
fi
#exit
#
# Create the swap file
#
echo
echo "[-] Use fallocate to create swap file"
fallocate -l $swsz /swapfile
#
# Change perms on swapfile
#
chmod 600 /swapfile
#
# Making the swapfile
#
mkswap /swapfile
#
# Activate swap
#
swapon /swapfile
#
# Edit fstab
#
echo
echo "[-] Swap created. edit fstab"
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
#
# Verify swap
#
echo 
echo "[-] Verify swap!"
swapon --show
free -m
echo
echo "[-] Script complete, exit"
exit 1

