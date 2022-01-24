#!/bin/bash

# 变量定义
newNginxTar="nginx-1.21.5.tar.gz"
tarPkgPath="/home/muzi/winShared/Scripts/pkg/"
# 校验安装包是否存在
sh check_pkg.sh $tarPkgPath$newNginxTar
if [ $? -ne 0 ];then
	echo "pkg file:[ $newNginxTar ] is ok"
else
	echo "Error: pkg file:[ $newNginxTar ] error, please confirm it"
	exit 0
fi


# 安装yum
# yum install -y epel-release
yum install -y gcc gcc-c++ pcre pcre-devel  zlib zlib-devel  openssl openssl-devel


# 安装nginx
tar zxf $tarPkgPath$newNginxTar -C /usr/local/
nginxInstallDir=`echo $newNginxTar |awk -F ".tar.gz" '{print $1}'`
cd /usr/local/$nginxInstallDir
./configure
make
make install
rm -rf /usr/local/$nginxInstallDir


# 开启并验证nginx进程
sudo /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
echo -e "\nps -ef|grep -v grep|grep nginx\n"
ps -ef|grep nginx
echo -e "\n"


# 开放端口
echo "firewall add-port:"
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
