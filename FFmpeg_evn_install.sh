#!/bin/bash

# 变量定义
installPackages="ffmpeg-release-amd64-static.tar.xz"
# tarPkgPath="/home/muzi/winShared/Scripts/pkg/"
pkgPathPart="/pkg/"
DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd);
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

# 安装ffmpeg
cp $tarPkgPath$installPackages /usr/local/
cd /usr/local/
xz -d $installPackages
ffmpegTarTmp=`ls|grep ffmpeg`
tar xf $ffmpegTarTmp
ffmpegInstallDir=`ls|grep ffmpeg|grep -v tar`
cp $ffmpegInstallDir"/ffmpeg" /usr/bin/
cp $ffmpegInstallDir"/ffprobe" /usr/bin/

ffmpeg -version|grep "ffmpeg version"
echo -e "\nffmpeg installed complete"
echo `ls -l /usr/bin/ffmpeg`
echo `ls -l /usr/bin/ffprobe`

# set -x 			# 对脚本内部部分代码进行跟踪，被跟踪的代码以set -x开始，于set +x结束

rm -rf /usr/local/$ffmpegInstallDir
rm $ffmpegTarTmp

# set +x
