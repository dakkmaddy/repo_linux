#!/bin/bash
#
# Patricia, the consolided port scanner.
# Port aggregation tester resulting in comprehensive indicators and answers
# Run once in background, do something else
# Less doubt it scanned all thoroughly
# 
# Check script for single arguement (ip address)
# End IP address check
ipa=$1
echo -n "Be advised the current directory is " && pwd
echo "Creating outfile results.txt"
touch results.txt
sleep 2
direct=$(pwd)
file=$direct/results.txt
echo "Verify host is alive"
alive=$(fping $ipa | grep -c alive)
if [ $alive -lt 1 ]
then
	echo "Host is not alive"
	rm results.txt
	echo "exiting ..."
	exit
fi
echo -n "Date / Time is " | tee -a $file && date | tee -a $file
echo "step 0 create a port list "
nmap $ipa -T 4 | grep tcp | cut -d' ' -f1 | sed -r 's/.{4}$//' > portlist.txt
echo
echo "step 1 quick nmap " | tee -a $file
nmap $ipa | tee -a portscanresults.txt | tee -a $file
echo "step 2 UDP nmap" | tee -a $file
echo
nmap -sU --top-ports 20 $ipa | tee -a $file
echo "step 3 massscan : Omitted (run solo if needed" | tee -a $file
echo
#cd /home/dakkmaddy/GitHub/massscan/masscan-master/bin/
#for ((x=1; x<6; x++ ))
#do
#	echo -n "masscan run " && echo $x | tee -a temp.txt
#	echo | tee -a $file
#	masscan --rate=1000 -e tun0 --ports 1-65535 $ipa | tee -a temp.txt
#done
#echo
cat temp.txt >> $file
cd $direct
echo "step 4: Aggressive nmap" | tee -a $file
nmap -sV -O -A $ipa | tee -a $file
echo
echo "step 5: xprobe2" | tee -a $file
xprobe2 -v $ipa | tee -a $file
echo
echo "step 6 nmap all ports! REALLY FAST" | tee -a $file
nmap -p- $ipa -T5 | tee -a $file
echo "step 7 ippsec nmap" | tee -a $file
nmap -sV -sC $ipa | tee -a $file
echo 
#echo "Step 8 unicornscan" | tee -a $file
#unicornscan -v $ipa | tee -a $file
echo "Verifying services " | tee -a $file
echo 
for z in $(cat portlist.txt)
do
	echo "Checking services on port $z" | tee -a $file
	echo | tee -a $file
	echo "" | nc -vnv $ipa $z -w1
done
rm portlist.txt
echo "DONE!" | tee -a $file
echo -n "Date / Time is " | tee -a $file && date | tee -a $file
echo "The outfile is : "
echo $file
echo "enjoy!"
exit
