#!/bin/bash
#
# This tools takes user input and checks certificate expiration
#
clear
read -p "[*] Good Day! Please enter the site you need to check like this site.domain:port " site
echo "[*] Checking with openssl ... "
sleep 1
echo -n "[*] certificate for " && echo -n $site | sed 's/:443//' && echo -n " expires on "
echo | openssl s_client -servername NAME -connect $site 2>/dev/null | openssl x509 -noout -dates | grep "notAfter" | sed 's/notAfter=//'
exit

