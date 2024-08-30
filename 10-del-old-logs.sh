#!/bin/bash

#delete log files periodically using crontab

source_dir=/home/ec2-user/logs
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ ! -d $source_dir ]
then
    echo "$source_dir does not exist, please check"
    exit 1
else
    echo "$source_dir exists"
fi

files=$(find $source_dir -name "*.log" -mtime +14)
echo "files: $files"

while IFS= read -r file
do
    echo "deleting file: $file"
    rm -rf $file
done <<< $files

