#!/bin/bash

PERMS=""
read -p "Enter the name of the file > " NAME
# lines 7, 9, & 11 all concatenate the answers given together
read -p "Do you want to allow read permissions? 1/0 > " READ
PERMS+=$READ
read -p "Do you want to allow write permissions? 1/0 > " WRITE
PERMS+=$WRITE
read -p "Do you want to allow execute permissions? 1/0 > " X
PERMS+=$X
DECIMAL=$(echo "$((2#$PERMS))") # converting binary permissions into decimal number for chmod
echo "decimal = $DECIMAL" #debug 
echo "Changing file permissions for $NAME for user ltsmith..."
chmod "$DECIMAL"00 $NAME #where file perms actually get modified
ls -l $NAME #Verify permissions
