#!/bin/bash

# 变量定义
installPackages="nginx-1.21.5.tar.gz"
# tarPkgPath="/home/muzi/winShared/Scripts/pkg/"
pkgPathPart="/pkg/"
DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd);
tarPkgPath=$DIR$pkgPathPart
# 校验安装包是否存在
check_pkg_sh=`echo $tarPkgPath |awk -F "pkg/" '{print $1}'`"check_pkg.sh"
sh $check_pkg_sh $tarPkgPath$installPackages
if [ $? -ne 0 ];then
	echo "pkg file:[ $installPackages ] is ok"
else
	echo "Error: pkg file:[ $installPackages ] error, please confirm it"
	exit 0
fi


# 安装yum
# yum install -y epel-release
yum install -y gcc gcc-c++ pcre pcre-devel  zlib zlib-devel  openssl openssl-devel


# 安装nginx
tar zxf $tarPkgPath$installPackages -C /usr/local/
nginxInstallDir=`echo $installPackages |awk -F ".tar.gz" '{print $1}'`
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
# set -x 			# 对脚本内部部分代码进行跟踪，被跟踪的代码以set -x开始，于set +x结束
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
# set +x
