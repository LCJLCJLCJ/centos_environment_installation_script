#!/bin/bash


# 安装go
tar zxf /home/muzi/winShared/Scripts/go1.17.4.linux-amd64.tar.gz -C /usr/local/
sed -i '$a export GOROOT=/usr/local/go' /etc/profile
sed -i '$a export GOPATH=$HOME/go' /etc/profile
sed -i '$a export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' /etc/profile
# source /etc/profile
# sed -i '$a source /etc/profile' ~/.bashrc

