#!/bin/bash

userid=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Log_folder="/var/log/shell-script/"
script_name=$(echo $0 | cut -d "." -f1)
Timestamp=$(date +%y-%m-%d-%H-%M-%S)
logfile="$Log_folder/$script_name-$Timestamp"
mkdir -p $Log_folder

root_check(){
    if [ $userid -ne 0 ]
    then
        echo -e "$R Please run the script with root privileges $N" | tee -a $logfile
        exit 1
    fi
}

validate(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R FAILED $N" | tee -a $logfile
        exit 1
    else
        echo -e "$2 is $G SUCESS $N" | tee -a $logfile
    fi
}

usage(){
    echo -e "$R USAGE:: $N sudo sh 09-loops.sh package1, package2,..." | tee -a $logfile
    exit 1
}

root_check

if [ $# -eq 0 ]
then
    usage
fi

for package in $@ #$@ refers to all the arguments passed into
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo "$package is not installed, doing it now" | tee -a $logfile
        dnf install $package -y &>>$logfile
        validate $? "Installing $package" | tee -a $logfile
    else
        echo -e "$package is already installed, $Y nothing to do $N" | tee -a $logfile
    fi
done