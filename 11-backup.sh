#!/bin/bash

source_dir=$1
destination_dir=$2
days=${3:-14} #if not provided by user, take as 14
timestamp=$(date +%y-%m-%d-%H-%D-%S)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

usage(){
    echo -e "$R USAGE::$N sh 11-backup.sh <source> <destination> <days(optional)>"
}

if [ $# -lt 2 ]
then
    usage
fi

if [ ! -d $source_dir ]
then
    echo -e "$R $source_dir does not exist, please check $N"
fi

if [ ! -d $destination_dir ]
then
    echo -e "$R $destination_dir does not exist, please check $N"
fi

FILES=$(find ${source_dir} -name "*.log" -mtime +$days)

if [ ! -z "$FILES" ]
then
    echo "files are found"
    zip_file="$destination_dir/app-logs-$timestamp.zip"
    find ${source_dir} -name "*.log" -mtime +$days | zip "$zip_file" -@
    
    #check if the files are zipped
    if [ -f "$zip_file" ]
    then
        echo -e "$G zipped log files older than $days days successfully $N"

        #remove log files post zip
        while IFS= read -r file
        do
            echo "Deleting file: $file"
            rm -rf $file
        done <<< "$FILES"
    else
        echo -e "$R zipping log files failed $N"
        exit 1
    fi
else
    echo "No files older than $days"
fi