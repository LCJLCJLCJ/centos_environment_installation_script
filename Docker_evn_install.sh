#!/bin/bash

yum -y install docker

systemctl start docker
systemctl enable docker
systemctl status docker
echo -e "\ndocker ps -a"
docker ps -a
echo -e "\ndocker images"
docker images
