#!/bin/bash
#
# Hex compare tool.
# Helps you compare you msfvenom payload, debugger pastes.
# Because doing it manually during CTP exam is a bad idea
# Do not ask me how I know!
# jmm April 2019
#
# Script requires two input files.
#
if [ $# -ne 2 ]; then
  echo 1>&2 "Usage: $0 debuggerfile msfvenomfile"
  exit 3
fi
clear
echo "[-] This script is best used with Kali Linux"
echo "[-] It is intended to compare the payload you generated with msfvenom to the binary paste from a debugger"
echo "[-] The debugger file should be the first arguement, otherwise, this script will not work"
read -p "[-] Hit enter to continue: " pause
# Defining new files with $1_out.txt and $2_out.txt
# 
file1=$1_out.txt
file2=$2_out.txt
echo "[-] New outfiles defined"
#
#
sleep 1
# Making a working directory
#
suffix=$(date +%m+%d+%yy+%H+%M)
mkdir compare_$suffix
echo "[-] Directory created!"
ls -l compare_$suffix
echo
sleep 1
# Removing junk from debugger file
#
# First copy the debugger file into a tmp file
cp $1 tmpdebugg.txt
# Now we can cut and echo back into the original argument!
cat tmpdebugg.txt | cut -d' ' -f3-19 > $1
rm tmpdebugg.txt
echo "[-] Copying files to new directory"
cp $1 $2 compare_$suffix/
cd compare_$suffix
sleep 1
#
# File conversion steps
#
# Step 1 remove hex notation \x
#
sed -i 's/\\x//g' $1
sed -i 's/\\x//g' $2
echo "[-] Hex notation \x removed from venom file"
sleep 1.5
#
# Step 2 remove any spaces
sed -i 's/ //g' $1
sed -i 's/ //g' $2
echo
echo "[-] Spaces removed!"
sleep 2
#
# Step 3 remove any new lines that may be in the files.
#
cat $1 | tr -d '\n' > $file1
cat $2 | tr -d '\n' > $file2
echo
echo "[-] New lines removed with translate. New outfile declared "
ls -l $file1 $file2
sleep 2
#
# Step 4 DOS to Unix
#
dos2unix $file1 $file2
echo "[-] Ran DOS2UNIX to remove any potential inconsistencies"
sleep 1
#
#
# Step 5 converting all characters to lowercase
#
tr '[:upper:]' '[:lower:]' $file1
tr '[:upper:]' '[:lower:]' $file2
echo "[-] Converted all to lower case, should not matter, but want to rule it out"
sleep 1
# Step 6 diff
echo "[-] running DIFF to see if there are any differences "
diff $file1 $file2
echo
echo "Checks complete. You may want to use GUI tools like CyberChef or Burp Comparer to augment this test"
exit
