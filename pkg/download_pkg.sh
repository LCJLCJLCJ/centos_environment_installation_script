#!/bin/bash

set -x 			# 对脚本内部部分代码进行跟踪，被跟踪的代码以set -x开始，于set +x结束

wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.28-1.el7.x86_64.rpm-bundle.tar

wget https://nginx.org/download/nginx-1.21.5.tar.gz

wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz

set +x
