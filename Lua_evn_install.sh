#!/bin/bash

# 变量定义
installPackages="lua-5.4.4.tar.gz"
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

# 安装lua
tar zxf $tarPkgPath$installPackages -C /usr/local/
luaInstallDir=`echo $installPackages |awk -F ".tar.gz" '{print $1}'`
cd /usr/local/$luaInstallDir
make
cd -

echo -e "\nlua install complete\nlua version is:"
lua -v

# set -x
rm -rf $luaInstallDir
# set +x
