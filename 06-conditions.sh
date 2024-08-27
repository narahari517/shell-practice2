#!/bin/bash

Num=$1

if [ $Num -lt 30 ]
then
    echo "Given number $Num is less than 30"
else
    echo "Given number $Num is greater than 30"
fi