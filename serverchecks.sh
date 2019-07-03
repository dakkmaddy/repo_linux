#Local Linux server checks
# jm 1-8-2018
# Update May 2018, using grep -v in processes, lighten load on directories
# Update August 2018, added Linux capabilities check
# Creating filename
#
filename=$(echo -n "LocalChecksforNagios-" && date +%F)
#
touch /root/$filename
#
clear
echo -n "Begin server checks for Nagios " && date +%F | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 1: uptime ... " | tee -a /root/$filename
uptime | tee -a /root/$filename
echo
echo "Check 2: disk space " | tee -a /root/$filename
#echo "Omitted. Check ESXi console. DF hangs after 6/5/18 yum update"
df -h | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 3: processes " | tee -a /root/$filename
echo | tee -a /root/$filename
ps -ef | grep -v /usr | grep -v /opt | grep -iv nagios | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 4: file system " | tee -a /root/$filename
cat /etc/fstab | tee -a /root/$filename
echo | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 5: who has logged in " | tee -a /root/$filename
who | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 6: established connections " | tee -a /root/$filename
netstat -naut | grep -i "Established" | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 7: listening TCP ports " | tee -a /root/$filename
netstat -tnlp | grep -i "Listen" | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 8: listening UDP ports " | tee -a /root/$filename
netstat -unlp | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 9: verify only root has UID 0" | tee -a /root/$filename
awk -F: '($3 == "0") {print}' /etc/passwd | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 10: wheel group ... " | tee -a /root/$filename
cat /etc/group | grep -i "wheel" | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 11: verify no empty passwords" | tee -a /root/$filename
awk -F: '($2 == "") {print}' /etc/shadow | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 12: lastlog " | tee -a /root/$filename
lastlog | grep -v "Never" | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 13: root cannot use SSH " | tee -a /root/$filename
cat /etc/ssh/sshd_config | grep "Permitroot" | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 14: verify no world writable files" | tee -a /root/$filename
find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 15: verify no owner files " | tee -a /root/$filename
find / -xdev \( -nouser -o -nogroup \) -print
echo | tee -a /root/$filename
echo "Check 16: verifying SUID GUID " | tee -a /root/$filename
find / \( -perm -4000 -o -perm -2000 \) -print | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 17: Linux capabilities." | tee -a /root/$filename
# Removing previous
/bin/rm -r /root/caps/capscheck.txt
getcap -r / 2>/dev/null | tee /root/caps/capscheck.txt
echo | tee -a /root/$filename
echo "Check 17a: Difference between baseline and current caps. Should be empty" | tee -a /root/$filename
diff /root/caps/capsbaseline.txt /root/caps/capscheck.txt | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 18: verify crontab " | tee -a /root/$filename
crontab -l | tee -a /root/$filename
echo "Check 19: for files new file in /home /tmp /var/tmp " | tee -a /root/$filename
today=`date +%Y-%m-%d`
sevenb4=$(date -d "$today - 7 days" +%Y-%m-%d)
#echo -n "now is " && echo $today echo -n "One week ago is " && echo $sevenb4
#exit
find /tmp -type f -newermt $sevenb4 ! -newermt $today | tee -a /root/$filename
find /var/tmp -type f -newermt $sevenb4 ! -newermt $today | tee -a /root/$filename
find /home -type f -newermt $sevenb4 ! -newermt $today | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Check 20: Check execute in home directories" | tee -a /root/$filename
ls -alRh /home | grep rwx | grep -v drwx | tee -a /root/$filename
echo "Check 21 : yum updates" | tee -a /root/$filename
yum check-updates | tee -a /root/$filename
echo | tee -a /root/$filename
#
echo "Check 22: Password Age Audit: " | tee -a /root/$filename
for user in $(grep -v "*" /etc/shadow | grep -v "!" | cut -d: -f1)
do
    echo "$user's password is $((($(date +%s)/86400)-$(grep "$user" /etc/shadow | cut -d: -f3))) days old."
done | tee -a /root/$filename
echo | tee -a /root/$filename
#
echo "Check 23: Sensitive files hash verification: " | tee -a /root/$filename
cat /etc/sum/thisweek.sum > /etc/sum/lastweek.sum
md5sum /etc/passwd /etc/sudoers /etc/shadow > /etc/sum/thisweek.sum
echo "Checking hash files. . ." | tee -a /root/$filename
echo "___________________________: " | tee -a /root/$filename
echo "This week's hashes: " | tee -a /root/$filename
md5sum -c /etc/sum/thisweek.sum | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Last week's hashes: " | tee -a /root/$filename
md5sum -c /etc/sum/lastweek.sum | tee -a /root/$filename
echo | tee -a /root/$filename
echo "Master file's hashes: " | tee -a /root/$filename
md5sum -c /root/sum/master.sum | tee -a /root/$filename
echo | tee -a /root/$filename
#
echo "Check 24: Check logs for failed authentication " | tee -a /root/$filename
tail -n 50 /var/log/secure* | grep failed | tee -a /root/$filename
echo -n "Script complete for " && date +%F | tee -a /root/$filename
echo | tee -a /root/$filename
