#!/bin/bash

var1=$1
var2=$2

Formula=${($var1*$var1)+(2*$var1*$var2)+($var2*$var2)}
echo "Result is: $Formula"
