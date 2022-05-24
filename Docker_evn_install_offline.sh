#!/bin/bash

# 变量定义
installPackages="docker-18.06.3-ce.tgz"
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


# 安装docker
cd /opt/
mkdir dockerInstallTmpDir
cd dockerInstallTmpDir
cp $tarPkgPath$installPackages /opt/dockerInstallTmpDir

# 生成docker.service文件
touch docker.service
echo "[Unit]" >> docker.service
echo "Description=Docker Application Container Engine" >> docker.service
echo "Documentation=https://docs.docker.com" >> docker.service
echo "After=network-online.target firewalld.service" >> docker.service
echo "Wants=network-online.target" >> docker.service
echo "  " >> docker.service
echo "[Service]" >> docker.service
echo "Type=notify" >> docker.service
echo "# the default is not to use systemd for cgroups because the delegate issues still" >> docker.service
echo "# exists and systemd currently does not support the cgroup feature set required" >> docker.service
echo "# for containers run by docker" >> docker.service
echo "ExecStart=/usr/bin/dockerd --selinux-enabled=false --insecure-registry=127.0.0.1" >> docker.service
echo "ExecReload=/bin/kill -s HUP $MAINPID" >> docker.service
echo "# Having non-zero Limit*s causes performance problems due to accounting overhead" >> docker.service
echo "# in the kernel. We recommend using cgroups to do container-local accounting." >> docker.service
echo "LimitNOFILE=infinity" >> docker.service
echo "LimitNPROC=infinity" >> docker.service
echo "LimitCORE=infinity" >> docker.service
echo "# Uncomment TasksMax if your systemd version supports it." >> docker.service
echo "# Only systemd 226 and above support this version." >> docker.service
echo "#TasksMax=infinity" >> docker.service
echo "TimeoutStartSec=0" >> docker.service
echo "# set delegate yes so that systemd does not reset the cgroups of docker containers" >> docker.service
echo "Delegate=yes" >> docker.service
echo "# kill only the docker process, not all processes in the cgroup" >> docker.service
echo "KillMode=process" >> docker.service
echo "# restart the docker process if it exits prematurely" >> docker.service
echo "Restart=on-failure" >> docker.service
echo "StartLimitBurst=3" >> docker.service
echo "StartLimitInterval=60s" >> docker.service
echo "  " >> docker.service
echo "[Install]" >> docker.service
echo "WantedBy=multi-user.target" >> docker.service

echo '解压tar包...'
tar -xvf $installPackages
cp docker/* /usr/bin/
chmod 777 /usr/bin/docker*

echo '将docker.service 移到/etc/systemd/system/ 目录...'
cp docker.service /etc/systemd/system/
echo '添加文件权限...'
chmod +x /etc/systemd/system/docker.service
echo '重新加载配置文件...'
systemctl daemon-reload
echo '启动docker...'
systemctl start docker
echo '设置开机自启...'
systemctl enable docker.service
echo 'docker安装成功...'
docker -v
systemctl status docker.service

# 删除临时文件夹
cd /opt
rm -rf dockerInstallTmpDir
