#!/bin/bash

userid=$(id -u)

root_check(){
    if [ $userid -ne 0 ]
    then
        echo "Please run the script with Root previleges"
        exit 1
    fi
}

R="\e[31m"
G="\e[32m"
N="\e[0m"

precheck(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R FAILED $N"
        exit 1
    else
        echo -e "$2 is $G SUCCESS $N"
    fi
}

root_check

dnf list installed git
if [ $? -ne 0 ]
then
    echo "Git is not installed, it will be installed now"
    dnf install git -y
    precheck $? "Git installation"
else
    echo "Git is already installed.."
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed, it will be installed now"
    dnf install mysqlss -y
    precheck $? "mysql installation"
else
    echo "mysql is already installed.."
fi
