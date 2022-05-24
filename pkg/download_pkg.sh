#!/bin/bash

set -x 			# 对脚本内部部分代码进行跟踪，被跟踪的代码以set -x开始，于set +x结束

wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.28-1.el7.x86_64.rpm-bundle.tar

wget https://nginx.org/download/nginx-1.21.5.tar.gz

wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz

wget https://go.dev/dl/go1.17.7.linux-amd64.tar.gz

wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.1.tgz

wget https://download.docker.com/linux/static/stable/x86_64/docker-18.06.3-ce.tgz

wget https://download.redis.io/releases/redis-7.0.0.tar.gz

wget http://www.lua.org/ftp/lua-5.4.4.tar.gz

set +x
