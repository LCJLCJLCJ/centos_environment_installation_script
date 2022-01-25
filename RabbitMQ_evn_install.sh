#!/bin/bash

# 系统里面是否有docker命令
type docker >/dev/null 2>&1 || { echo >&2 "I require docker but it's not installed.  Aborting."; exit 0; }
# 安装RabbitMQ
docker pull rabbitmq:3.8.27-management
docker images
docker run -d --hostname rabbitMQ --name my-rabbitMQ -p 15672:15672 -p 5672:5672 rabbitmq:3.8.27-management
docker ps -a|grep rabbitMQ
# 开端口
set -x 			# 对脚本内部部分代码进行跟踪，被跟踪的代码以set -x开始，于set +x结束
firewall-cmd --zone=public --add-port=5672/tcp --permanent
firewall-cmd --zone=public --add-port=15672/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
set +x
