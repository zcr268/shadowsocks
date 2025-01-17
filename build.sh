#!/bin/bash

if [ -d "shadowsocks" ];then
    echo "全部更新"
    version=`cat shadowsocks/ss/version|awk -F '.' '{for(i=1;i<=NF;i++){if(i!=NF){printf("%s.",$i)}else{printf("%s",$i+1)}}}'`
    echo $version > shadowsocks/ss/version
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
    # rm -rf shadowsocks
else
echo "仅更新脚本和说明"
fi

git status
echo -n "提交信息:"
read msg

# if false; then
    scp -P 22 shadowsocks.tar.gz version admin@192.168.50.110:/volume1/docker/nginx/home/
    git add .
    git commit -m "${file_name} ${md5} $msg"
    git push
# fi