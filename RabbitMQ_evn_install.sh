#!/bin/bash


# # 方法1  start：docker安装 (先注释掉，如果方法2不行再用这个方法)

# # 系统里面是否有docker命令
# type docker >/dev/null 2>&1 || { echo >&2 "I require docker but it's not installed.  Aborting."; exit 0; }
# # 安装RabbitMQ
# docker pull rabbitmq:3.8.27-management
# docker images
# docker run -d --hostname rabbitMQ --name my-rabbitMQ -p 15672:15672 -p 5672:5672 rabbitmq:3.8.27-management
# docker ps -a|grep rabbitMQ
# # 开端口
# firewall-cmd --zone=public --add-port=5672/tcp --permanent
# firewall-cmd --zone=public --add-port=15672/tcp --permanent
# firewall-cmd --reload
# firewall-cmd --zone=public --list-ports

# 方法1  end

# ---------------------------------------------------

# 方法2  start：rpm安装

# 变量定义
installPackages="rabbitmq-server-3.6.9-1.el7.noarch.rpm"

# cp 未完待续

cd /usr/local
wget --content-disposition https://packagecloud.io/rabbitmq/rabbitmq-server/packages/el/7/rabbitmq-server-3.6.9-1.el7.noarch.rpm/download.rpm
rpmMd5Shell=`md5sum $installPackages`
# d739a08b1845e35fe269da4b2e41f1c1  rabbitmq-server-3.6.9-1.el7.noarch.rpm
rpmMd5=`echo $rpmMd5Shell |awk -F " " '{print $1}'`
if [ $rpmMd5 == "d739a08b1845e35fe269da4b2e41f1c1" ];then
	echo "pkg file:[ $installPackages ] is ok"
else
	echo "error, rpm package is not [ $installPackages ]"
	exit 0
fi

# 安装
yum install -y epel-release
yum install -y erlang
yum install -y $installPackages
rabbitmq-server -detached
sleep 10

# 新增用户
user="muzi"
passwd="abc123456"
rabbitmqctl add_user $user $passwd
rabbitmqctl set_permissions -p / $user ".*" ".*" ".*"
rabbitmqctl set_user_tags $user administrator

# 开启管理页面
rabbitmq-plugins enable rabbitmq_management
systemctl restart rabbitmq-server

rm -rf $installPackages

# 方法2  end