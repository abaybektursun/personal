#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "This action requires sudo access!"
    exit 1
fi


user=`who|awk '{printf $1}'`
proxy="proxy-ccy.houston.hp.com:8080"

echo "
Acquire::http::proxy \"http://${proxy}/\";
Acquire::ftp::proxy \"ftp://${proxy}/\";
Acquire::https::proxy \"https://${proxy}/\";
" >> /etc/apt/apt.conf.d/95proxies;

echo "
http_proxy=\"http://${proxy}/\"
https_proxy=\"http://${proxy}/\"
ftp_proxy=\"http://${proxy}/\"
HTTP_PROXY=\"http://${proxy}/\"
HTTPS_PROXY=\"http://${proxy}/\"
FTP_PROXY=\"http://${proxy}/\"
" >> /etc/environment;

# Git
git config --global http.proxy http://${proxy}

sudo service network-manager restart;

echo "In Gnome System settings, change netowrking settings to use manual proxy: ${proxy}"
echo "If proxy canges were not applied, try rebooting"

