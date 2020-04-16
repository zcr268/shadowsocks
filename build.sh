#!/bin/bash
version=`cat shadowsocks/ss/version`
file_name="shadowsocks_${version}.tar.gz"
echo ${file_name}
tar -czf ${file_name} shadowsocks
md5=`md5sum ${file_name} |cut -d ' ' -f 1`
echo ${md5}
mv version version_bak
echo ${version} ${md5} > version
cat version_bak >> version
rm version_bak
cp ${file_name} shadowsocks.tar.gz
rm -rf shadowsocks

scp shadowsocks.tar.gz version admin@192.168.50.110:/volume1/docker/nginx/home/

git add .
git commit -m "${file_name} ${md5}"
git push