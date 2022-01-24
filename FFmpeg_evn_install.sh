#!/bin/bash

# 变量定义
newFFmpegTar="ffmpeg-release-amd64-static.tar.xz"
tarPkgPath="/home/muzi/winShared/Scripts/pkg/"

# 安装ffmpeg
cp $tarPkgPath$newFFmpegTar /usr/local/
cd /usr/local/
xz -d $newFFmpegTar
ffmpegTarTmp=`ls|grep ffmpeg`
tar xf $ffmpegTarTmp
ffmpegInstallDir=`ls|grep ffmpeg|grep -v tar`
cp $ffmpegInstallDir"/ffmpeg" /usr/bin/
cp $ffmpegInstallDir"/ffprobe" /usr/bin/

ffmpeg -version|grep "ffmpeg version"
echo -e "\nffmpeg installed complete"
echo `ls -l /usr/bin/ffmpeg`
echo `ls -l /usr/bin/ffprobe`

rm -rf /usr/local/$ffmpegInstallDir
rm $ffmpegTarTmp
