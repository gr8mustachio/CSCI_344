#!/bin/bash


ps -ef > processes.txt


#while read PID TIME CMD; do
#    echo no
#done < <(ps -ef | awk '
    
while read -r line; do
    PID=$(echo $line | awk '{print $2}')
    echo "PID: $PID" 
    TIME=$(echo $line | awk '$7 ~/([2-9][0-9])/ {print $7}')
    SECS=$(echo $TIME | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    echo "Seconds: $SECS"
    echo "Full Line: $line"
done < processes.txt
