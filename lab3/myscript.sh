#!/bin/bash

echo "Sum Script"


SUM=0
for num in $(seq 1 $#); do
    SUM=$(($SUM + $1))
    shift
done
echo $SUM
