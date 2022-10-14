#!/bin/bash

# 变量定义
installPackages="mysql-8.0.28-1.el7.x86_64.rpm-bundle.tar"
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


# # 安装yum
# for i in {1..3}
# do
# 	yum -y install epel-release gcc gcc-c++ python-crypto openssl openssl-devel supervisor wget python-pip python-setproctitle git pcre pcre-devel  zlib zlib-devel mysql-devel python-devel
# done


# 卸载mariadb
mariadbInstallmed=`rpm -qa | grep mariadb`
for i in $mariadbInstallmed
do
	echo $i
	echo "rpm -e $i --nodeps"
	rpm -e $i --nodeps
done
if [ ! `rpm -qa | grep mariadb` ]; then
	echo -e "mariadb is null >\nnext, install MySQL -->\n"
else
	echo `rpm -qa | grep mariadb`
	exit 1
fi


# 安装MySQL
mkdir -p /usr/local/mysql
cd /usr/local/mysql
tar xvf $tarPkgPath$installPackages -C /usr/local/mysql
mysql_common=`ls | grep "mysql-community-common"`
mysql_devel=`ls | grep "mysql-community-devel"`
mysql_libs=`ls | grep -v "compat"| grep "mysql-community-libs"`
mysql_libs_compat=`ls | grep "mysql-community-libs-compat"`
mysql_client=`ls | grep -v "plugins"|grep "mysql-community-client"`
mysql_server=`ls | grep "mysql-community-server"`
rpm -ivh $mysql_common --nodeps --force
rpm -ivh $mysql_devel --nodeps --force
rpm -ivh $mysql_libs --nodeps --force
rpm -ivh $mysql_libs_compat --nodeps --force
rpm -ivh $mysql_client --nodeps --force
rpm -ivh $mysql_server --nodeps --force
mysqld --initialize
chown mysql:mysql /var/lib/mysql -R
systemctl start mysqld.service
systemctl enable mysqld
mysql_grep_pwd=`grep 'temporary password' /var/log/mysqld.log`
mysql_pwd=`echo $mysql_grep_pwd |awk -F "localhost: " '{print $2}'`
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "copy such to use to MySQL's settings:"
echo " "
echo " "
echo " "
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';"
echo "use mysql;"
echo "update user set host='%' where user='root';"
# echo "select host, user, authentication_string, plugin from user;"
echo "exit"
echo " "
echo " "
echo " "
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
mysql -uroot -p$mysql_pwd
echo "exit MySQL"

# set -x 			# 对脚本内部部分代码进行跟踪，被跟踪的代码以set -x开始，于set +x结束
rm -rf /usr/local/mysql/
# set +x


# 开放端口
echo "firewall add-port:"
# set -x
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
# set +x
