#!/bin/bash

# 变量定义
installPackages="mongodb-linux-x86_64-3.0.1.tgz"
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


# 安装Mongodb
tar zxf $tarPkgPath$installPackages -C /usr/local/
sed -i '$a export PATH=$PATH:/usr/local/mongodb-linux-x86_64-3.0.1/bin' /etc/profile
# source /etc/profile
echo -e "手动执行下>>>>  \n              source /etc/profile \n命令 \n,(这个问题留着后面解决一下)"



# 测试Mongodb安装
# 先在/home/user1下新建一个目录data存放Mongodb数据:

# mkdir /home/user1/data
# 用以下命令启动mongod:

# mongod --dbpath /home/user1/data
# 这时mongod已经启动，重新打开一个终端, 键入mongo进入交互程序：

# $> mongo
# > show dbs
# ...数据库列表
# Mongodb安装到此为止