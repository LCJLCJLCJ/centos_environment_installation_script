#!/bin/bash


# 选择要安装的软件并执行相应的安装脚本
scriptPath=`echo $0 |awk -F "newSystemEvn_install.sh" '{print $1}'`
case "$1" in
yum)
       for i in {1..3}
       do
            yum -y install epel-release
       done
       yum -y install epel-release gcc gcc-c++ python-crypto openssl openssl-devel supervisor wget python-pip python-setproctitle git
       yum -y install pcre pcre-devel  zlib zlib-devel  openssl openssl-devel
       yum -y install mysql-devel python-devel
       ;;
mysql)
       echo -e "run MySQL_evn_install.sh \n"
       sh $scriptPath"MySQL_evn_install.sh"
       ;;
mysql_57)
       echo -e "run MySQL_57_evn_install.sh \n"
       sh $scriptPath"MySQL_57_evn_install.sh"
       ;;
nginx)
       echo -e "run Nginx_evn_install.sh \n"
       sh $scriptPath"Nginx_evn_install.sh"
       ;;
ffmpeg)
       echo -e "run FFmpeg_evn_install.sh \n"
       sh $scriptPath"FFmpeg_evn_install.sh"
       ;;
docker)
       echo -e "run Docker_evn_install.sh \n"
       sh $scriptPath"Docker_evn_install.sh"
       ;;
docker_offline)
       echo -e "run Docker_evn_install_offline.sh \n"
       sh $scriptPath"Docker_evn_install_offline.sh"
       ;;
rabbitmq)
       echo -e "run RabbitMQ_evn_install.sh \n"
       sh $scriptPath"RabbitMQ_evn_install.sh"
       ;;
go)
       echo -e "run Golang_evn_install.sh \n"
       sh $scriptPath"Golang_evn_install.sh"
       ;;
beego)
       echo -e "run Beego_evn_install.sh \n"
       sh $scriptPath"Beego_evn_install.sh"
       ;;
mongodb)
       echo -e "run Mongodb_evn_install.sh \n"
       sh $scriptPath"Mongodb_evn_install.sh"
       ;;
redis)
       echo -e "run Redis_evn_install.sh \n"
       sh $scriptPath"Redis_evn_install.sh"
       ;;
lua)
       echo -e "run Lua_evn_install.sh \n"
       sh $scriptPath"Lua_evn_install.sh"
       ;;
rmDockerEnv)
       echo -e "run Uninstall_Docker_evn_.sh to remove docker env\n"
       sh $scriptPath"Uninstall_Docker_evn_.sh"
       ;;
*)
       # echo -e "Usage:\n $0 __xxx__\n\n__xxx__ include such as:\n{\n  yum | mysql | nginx | ffmpeg | docker \n}"
       # echo -e "Usage:\n $0 { yum || beego | docker | docker_offline | ffmpeg | go | lua | mongodb | mysql | mysql_57 | nginx | rabbitmq | redis ||| rmDockerEnv }"
       echo "Need the required parameters,
Usage:
$0 __xxx__
__xxx__ contain such as:
{ 
| yum | beego | docker | docker_offline | ffmpeg | go | lua | mongodb | mysql | mysql_57 | nginx | rabbitmq | redis | rmDockerEnv | 
}"
       exit 1
esac

# exit 0