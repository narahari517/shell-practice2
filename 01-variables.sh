#!/bin/bash

var1=$1
var2=$2

Formula=${($1*$1)+(2*$1*$2)+($2*$2)}
echo "Result is: $Formula"
