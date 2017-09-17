#!/bin/bash

# WARNING: This will tr --squeeze-repeats '\n' (replace multiple new lines with one new line) in these files:
#  /etc/environment
#  /etc/apt/apt.conf.d/95proxies

if [ "$(id -u)" != "0" ]; then
    echo "This action requires sudo access!"
    exit 1
fi


proxy='proxy-ccy.houston.hp.com:8080'

# Evn. variable
sed -i -e "s#http_proxy=\"http://${proxy}/\"##g" /etc/environment
sed -i -e "s#https_proxy=\"http://${proxy}/\"##g" /etc/environment
sed -i -e "s#ftp_proxy=\"http://${proxy}/\"##g" /etc/environment
sed -i -e "s#HTTP_PROXY=\"http://${proxy}/\"##g" /etc/environment
sed -i -e "s#HTTPS_PROXY=\"http://${proxy}/\"##g" /etc/environment
sed -i -e "s#FTP_PROXY=\"http://${proxy}/\"##g" /etc/environment

sed -i -e "s#http_proxy=''##g" /etc/environment
sed -i -e "s#https_proxy=''##g" /etc/environment
sed -i -e "s#ftp_proxy=''##g" /etc/environment
sed -i -e "s#HTTP_PROXY=''##g" /etc/environment
sed -i -e "s#HTTPS_PROXY=''##g" /etc/environment
sed -i -e "s#FTP_PROXY=''##g" /etc/environment

echo "
http_proxy=''
https_proxy=''
ftp_proxy=''
HTTP_PROXY=''
HTTPS_PROXY=''
FTP_PROXY=''
" >> /etc/environment;

tr -s '\n' < /etc/environment > /etc/environment2
mv /etc/environment2 /etc/environment

env -u http_proxy;
env -u https_proxy;
env -u ftp_proxy;
env -u HTTP_PROXY;
env -u HTTPS_PROXY;
env -u FTP_PROXY;

# Apt
sudo sed -i -e "s#Acquire::http::proxy \"http://${proxy}/\";##g" /etc/apt/apt.conf.d/95proxies;
sudo sed -i -e "s#Acquire::ftp::proxy \"ftp://${proxy}/\";##g" /etc/apt/apt.conf.d/95proxies;
sudo sed -i -e "s#Acquire::https::proxy \"https://${proxy}/\";##g" /etc/apt/apt.conf.d/95proxies;

sudo tr -s '\n' < /etc/apt/apt.conf.d/95proxies > /etc/apt/apt.conf.d/95proxies2
sudo mv /etc/apt/apt.conf.d/95proxies2 /etc/apt/apt.conf.d/95proxies

# Git
git config --global --unset http.proxy

sudo service network-manager restart;
