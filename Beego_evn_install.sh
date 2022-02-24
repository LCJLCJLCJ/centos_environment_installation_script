#!/bin/bash

# 变量定义
newBeegoTar="beego_install_pkg.tar.gz"
tarPkgPath="/home/muzi/winShared/Scripts/pkg/"
includeGo="go1.15.6.linux-amd64.tar.gz"
# 校验安装包是否存在
check_pkg_sh=`echo $tarPkgPath |awk -F "pkg/" '{print $1}'`"check_pkg.sh"
sh $check_pkg_sh $tarPkgPath$newBeegoTar
if [ $? -ne 0 ];then
	echo "pkg file:[ $newBeegoTar ] is ok"
else
	echo "Error: pkg file:[ $newBeegoTar ] error, please confirm it"
	echo "or"
	echo "Download from: [ 链接：https://pan.baidu.com/s/1KUQfl-2VeGZAslGCDg5qqQ?pwd=bego 提取码：bego ]"
	exit 0
fi

# 判断系统中有没有安装过Go
go version
if [ $? -ne 0 ]; then
	goInstallCommand=`echo $0 |awk -F "Beego_evn_install.sh" '{print $1}'`
    echo "the GoLang environment is not available, perform [ sh ${goInstallCommand}newSystemEvn_install.sh go ] to install GoLang environment"
    exit 0
else
    echo "GoLang is exist, next install beego"
fi


mkdir -p /home/tmpBeegoInstallDir
tar zxvf $tarPkgPath$newBeegoTar -C /home/tmpBeegoInstallDir/
tmpBeegoInstallDirPkgs=`echo $newBeegoTar |awk -F ".tar.gz" '{print $1}'`

mkdir -p /usr/local/gopackage/src/github.com/astaxie/
tar zxf /home/tmpBeegoInstallDir/${tmpBeegoInstallDirPkgs}/beego.tar.gz -C /usr/local/gopackage/src/github.com/astaxie/
tar zxf /home/tmpBeegoInstallDir/${tmpBeegoInstallDirPkgs}/bee.tar.gz -C /usr/local/gopackage/src/github.com/astaxie/beego/

cd /usr/local/gopackage/src/github.com/astaxie/beego/bee/
go env -w GOPROXY=https://goproxy.cn
go build

# 校验安装后是否得到二进制文件 bee
sh $check_pkg_sh /usr/local/gopackage/src/github.com/astaxie/beego/bee/bee
if [ $? -ne 0 ];then
	echo "file:[ /usr/local/gopackage/src/github.com/astaxie/beego/bee/bee ] is ok, install success"
else
	echo "Error: file:[ /usr/local/gopackage/src/github.com/astaxie/beego/bee/bee ] error, please confirm it"
	exit 0
fi

cp /usr/local/gopackage/src/github.com/astaxie/beego/bee/bee /usr/local/go/bin/

bee version


rm -rf /home/tmpBeegoInstallDir



# 按需求要不要执行：
# export GO111MODULE=off
# 或者
# export GO111MODULE=on