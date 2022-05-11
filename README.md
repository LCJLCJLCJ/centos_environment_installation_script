# centos7 搭建环境

目前脚本有 mysql 、 nginx 、 ffmpeg 、 docker

可以通过newSystemEvn_install.sh脚本选择安装:
```
sh newSystemEvn_install.sh {yum | mysql | nginx | ffmpeg | docker}
```

注意：
1. 安装所需用到的tar包等安装包需提前在pkg目录中下载
2. 需要根据自己实际情况更改脚本中的:  tarPkgPath="/home/Scripts/pkg/"