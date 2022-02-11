#!/bin/bash

# 变量定义
newGolangTar="go1.17.7.linux-amd64.tar.gz"
tarPkgPath="/home/muzi/winShared/Scripts/pkg/"
# 校验安装包是否存在
check_pkg_sh=`echo $tarPkgPath |awk -F "pkg/" '{print $1}'`"check_pkg.sh"
sh $check_pkg_sh $tarPkgPath$newGolangTar
if [ $? -ne 0 ];then
	echo "pkg file:[ $newGolangTar ] is ok"
else
	echo "Error: pkg file:[ $newGolangTar ] error, please confirm it"
	exit 0
fi


# 安装golang
tar zxf $tarPkgPath$newGolangTar -C /usr/local/
mkdir -p /usr/local/gopackage
sed -i '$a export GOROOT=/usr/local/go' /etc/profile
sed -i '$a export GOPATH=/usr/local/gopackage' /etc/profile
sed -i '$a export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' /etc/profile
# source /etc/profile
echo -e "手动执行下>>>>  \n              source /etc/profile \n命令 \n,(这个问题留着后面解决一下)"

echo "go version"
go version
