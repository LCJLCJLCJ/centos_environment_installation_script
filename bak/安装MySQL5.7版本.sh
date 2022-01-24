#!/bin/bash

# 安装yum
for i in {1..3}
do
	yum -y install epel-release gcc gcc-c++ python-crypto openssl openssl-devel supervisor wget python-pip python-setproctitle git pcre pcre-devel  zlib zlib-devel mysql-devel python-devel
done


# # 安装MySQL
# cd /usr/local/
# cp /home/muzi/winShared/Scripts/mysql57-community-release-el7-11.noarch.rpm /usr/local/
# # wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
# # if [ ! -f "mysql57-community-release-el7-11.noarch.rpm" ]; then
# # 	echo "No such file:[ mysql57-community-release-el7-11.noarch.rpm ]"
# # 	exit 1
# # fi
# yum -y localinstall mysql57-community-release-el7-11.noarch.rpm
# yum -y install mysql-community-server
# systemctl start mysqld 
# systemctl enable mysqld 
# mysql_grep_pwd=`grep 'temporary password' /var/log/mysqld.log`
# mysql_pwd=`echo $mysql_grep_pwd |awk -F "localhost: " '{print $2}'`
# echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111"
# echo "copy such to use to MySQL's settings:"
# echo " "
# echo " "
# echo " "
# echo "set global validate_password_policy=0; set global validate_password_length=1;"
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';"
# echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"
# echo "exit"
# echo " "
# echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111"
# mysql -uroot -p$mysql_pwd
# echo "exit MySQL"
# rm -f /usr/local/mysql57-community-release-el7-11.noarch.rpm


# 开放一些端口
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=8008/tcp --permanent
firewall-cmd --zone=public --add-port=8000/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=public --list-ports


# # 安装go
# tar zxf /home/muzi/winShared/Scripts/go1.17.4.linux-amd64.tar.gz -C /usr/local/
# sed -i '$a export GOROOT=/usr/local/go' /etc/profile
# sed -i '$a export GOPATH=$HOME/go' /etc/profile
# sed -i '$a export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' /etc/profile
# source /etc/profile


