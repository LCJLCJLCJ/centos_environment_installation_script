#!/bin/bash

# 变量定义
installPackages="redis-7.0.0.tar.gz"
tarPkgPath="/home/muzi/winShared/Scripts/pkg/"
# 校验安装包是否存在
check_pkg_sh=`echo $tarPkgPath |awk -F "pkg/" '{print $1}'`"check_pkg.sh"
sh $check_pkg_sh $tarPkgPath$installPackages
if [ $? -ne 0 ];then
	echo "pkg file:[ $installPackages ] is ok"
else
	echo "Error: pkg file:[ $installPackages ] error, please confirm it"
	exit 0
fi


# 检测是否有gcc环境
echo " "
gcc -v
if [ $? -ne 0 ];then
	echo "Error: [ gcc & gcc-c++ ] error, please confirm it"
	yum install -y gcc gcc-c++
else
	echo "[ gcc & gcc-c++ ] is ok"
fi


# 安装redis
tar zxf $tarPkgPath$installPackages -C /usr/local/
redisInstallDir=`echo $installPackages |awk -F ".tar.gz" '{print $1}'`
cd /usr/local/$redisInstallDir
make
cd src
make PREFIX=/usr/local/redis install
mv /usr/local/redis/bin/* /usr/bin/

# 配置redis
cd /usr/local/$redisInstallDir
cp /usr/local/${redisInstallDir}/redis.conf /usr/local/redis
cp /usr/local/${redisInstallDir}/redis.conf /etc/
sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/g" /etc/redis.conf
sed -i "s/# requirepass foobared/requirepass root/g" /etc/redis.conf
sed -i "s/daemonize no/daemonize yes/g" /etc/redis.conf
# 将redis加入到开机启动
# echo "redis-server /etc/redis.conf" >> /etc/rc.local

# 开启redis服务
redis-server /etc/redis.conf

cd /usr/local
rm -rf $redisInstallDir

# 开放端口
echo "firewall add-port:"
firewall-cmd --zone=public --add-port=6379/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=public --list-ports



# 卸载删除redis
echo " "
echo " "
echo " "
echo "卸载删除redis:------start------>"
echo "rm -rf /usr/local/redis/"
echo "rm -f /usr/bin/redis*"
echo "rm -f /etc/redis.conf"
echo "卸载删除redis:-------end-------<"
