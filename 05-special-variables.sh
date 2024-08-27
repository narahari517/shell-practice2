#!/bin/bash

echo "All variables passed to the script: $@"
echo "Number of variables passed: $#"
echo "Name of the running script: $0"
echo "Current working directory: $PWD"
echo "Home directory of the current user: $HOME"
echo "PID of the script executing now: $$"
sleep 100 &
echo "PID of the last background command: $!"
