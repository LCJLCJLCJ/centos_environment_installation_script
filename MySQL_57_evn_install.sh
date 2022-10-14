#!/bin/bash

# 变量定义
installPackages="MySQL57_install_pkg.tar.gz"
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
	echo "or"
	echo "Download from: [ 链接：https://pan.baidu.com/s/1XYHj8dzS1BF8Riv7lrzrgQ?pwd=mysq 提取码：mysq ]"
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

cd `echo $installPackages |awk -F ".tar.gz" '{print $1}'`
#开始安装MySQL，注意：这些包安装是有顺序的
rpm -ivh libaio-0.3.109-13.el7.x86_64.rpm
#判断安装的过程是否成功
if [ $? == 0 ];then
	echo -e "安装------libaio-0.3.109-13.el7.x86_64.rpm  --  第1个包------- 成功"
else
	echo -e "安装------libaio-0.3.109-13.el7.x86_64.rpm  --  第1个包------- 失败"
fi
#第二个包
rpm -ivh perl-Data-Dumper-2.145-3.el7.x86_64.rpm
if [ $? == 0 ];then
        echo -e "安装------perl-Data-Dumper-2.145-3.el7.x86_64.rpm  --  第2个包------- 成功"
else
        echo -e "安装------perl-Data-Dumper-2.145-3.el7.x86_64.rpm  --  第2个包------- 失败"
fi
#第三个包：安装rpm -ivh numactl* 这是安装以前缀numactl开始的所有安装包
rpm -ivh numactl*
if [ $? == 0 ];then
        echo -e "安装------numactl*  --  第3个包------- 成功"
else
        echo -e "安装------numactl*  --  第3个包------- 失败"
fi
#第四个包：解压mysql-5.7.26-1.el7.x86_64.rpm-bundle.tar
tar -xf mysql-5.7.26-1.el7.x86_64.rpm-bundle.tar
if [ $? == 0 ];then
        echo -e "解压------mysql-5.7.26-1.el7.x86_64.rpm-bundle.tar  ------- 成功"
else
        echo -e "解压------mysql-5.7.26-1.el7.x86_64.rpm-bundle.tar  ------- 失败"
fi
#第四个包：安装 mysql-community-common-5.7.26-1.el7.x86_64.rpm
rpm -ivh mysql-community-common-5.7.26-1.el7.x86_64.rpm

if [ $? == 0 ];then
        echo -e "安装------mysql-community-common-5.7.26-1.el7.x86_64.rpm  --  第4个包------- 成功"
else
        echo -e "安装------mysql-community-common-5.7.26-1.el7.x86_64.rpm  --  第4个包------- 失败"
fi
#第五个包：安装mysql-community-libs-*
rpm -ivh mysql-community-libs-*

if [ $? == 0 ];then
        echo -e "安装------mysql-community-libs-*  --  第5个包------- 成功"
else
        echo -e "安装------mysql-community-libs-*  --  第5个包------- 失败"
fi
#第六个包：安装mysql-community-devel-5.7.26-1.el7.x86_64.rpm
rpm -ivh mysql-community-devel-5.7.26-1.el7.x86_64.rpm
if [ $? == 0 ];then
        echo -e "安装------mysql-community-devel-5.7.26-1.el7.x86_64.rpm  --  第6个包------- 成功"
else
        echo -e "安装------mysql-community-devel-5.7.26-1.el7.x86_64.rpm  --  第6个包------- 失败"
fi
#第七个包：安装net-tools-2.0-0.25.20131004git.el7.x86_64.rpm
rpm -ivh net-tools-2.0-0.25.20131004git.el7.x86_64.rpm
if [ $? == 0 ];then
        echo -e "安装------net-tools-2.0-0.25.20131004git.el7.x86_64.rpm  --  第7个包------- 成功"
else
        echo -e "安装------net-tools-2.0-0.25.20131004git.el7.x86_64.rpm  --  第7个包------- 失败"
fi
#第八个包：安装mysql-community-client-5.7.26-1.el7.x86_64.rpm
rpm -ivh mysql-community-client-5.7.26-1.el7.x86_64.rpm
if [ $? == 0 ];then
        echo -e "安装------mysql-community-client-5.7.26-1.el7.x86_64.rpm  --  第8个包------- 成功"
else
        echo -e "安装------mysql-community-client-5.7.26-1.el7.x86_64.rpm  --  第8个包------- 失败"
fi
#第九个包：安装mysql-community-server-5.7.26-1.el7.x86_64.rpm
rpm -ivh mysql-community-server-5.7.26-1.el7.x86_64.rpm
if [ $? == 0 ];then
        echo -e "安装------mysql-community-server-5.7.26-1.el7.x86_64.rpm  --  第9个包------- 成功"
else
        echo -e "安装------mysql-community-server-5.7.26-1.el7.x86_64.rpm  --  第9个包------- 失败"
fi

cd -
#启动MySQL
service mysqld start
#验证是否启动成功可以查看MySQL的启动状态
service mysqld status >/var/log/mysql57start.log

mysql_grep_pwd=`grep 'temporary password' /var/log/mysqld.log`
mysql_pwd=`echo $mysql_grep_pwd |awk -F "localhost: " '{print $2}'`
# echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
# echo "copy such to use to MySQL's settings:"
# echo " "
# echo " "
# echo " "
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';"
# echo "use mysql;"
# echo "update user set host='%' where user='root';"
# # echo "select host, user, authentication_string, plugin from user;"
# echo "exit"
# echo " "
# echo " "
# echo " "
# echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
# mysql -uroot -p$mysql_pwd
#进入MySQL的交互模式，修改相应的参数，设置简单的密码为root
mysql  -uroot -p${mysql_pwd} --connect-expired-password <<EOF
		set global validate_password_policy=0;
		set global validate_password_length=1;
		ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';

		GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
		flush privileges;

		quit

EOF

echo "MySQL install OK"


rm -rf /usr/local/mysql/


# 开放端口
echo "firewall add-port:"
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
