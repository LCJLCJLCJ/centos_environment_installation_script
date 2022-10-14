#!/bin/bash

# 变量定义
installPackages="go1.17.7.linux-amd64.tar.gz"
# tarPkgPath="/home/muzi/winShared/Scripts/pkg/"
pkgPathPart="/pkg/"
# 脚本所在的目录:
DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd);
# 脚本所在目录加上 pkgPathPart 合并为安装tar包的目录:
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


# 安装golang
tar zxf $tarPkgPath$installPackages -C /usr/local/
mkdir -p /usr/local/gopackage
sed -i '$a export GOROOT=/usr/local/go' /etc/profile
sed -i '$a export GOPATH=/usr/local/gopackage' /etc/profile
sed -i '$a export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' /etc/profile
source /etc/profile
# echo -e "手动执行下>>>>  \n              source /etc/profile \n命令 \n,(这个问题留着后面解决一下)"
echo -e "对于shell脚本执行 source /etc/profile 不能在脚本外部生效，问题解决办法：
1.手动执行下source /etc/profile
2.重启系统也可恢复正常"

echo "go version"
go version
