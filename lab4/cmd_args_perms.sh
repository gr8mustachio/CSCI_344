#!/bin/bash

echo "Passing file permissions as cmd arguments..."
PERMS="000" #Since we will be doing string manipulation to get this to the proper binary number in 3 bits, we need to set it as '000' to begin with
for args in $(seq 1 $#); do
    case $1 in      #decided on case statement since its easier to implement then if/else, and this way the order 
                    #the arguments come in doesn't matter
                    # Here we do the string manipulation on PERMS
        read)       PERMS=$(echo $PERMS | sed s/./1/1);;
        write)      PERMS=$(echo $PERMS | sed s/./1/2);;
        execute)    PERMS=$(echo $PERMS | sed s/./1/3);;
        *)          NAME=$1;; # any other argument that isn't a permission is interpreted as the name of the file
    esac
    shift
done

echo "Permissions = $PERMS" #Checking to see if correct
echo "Modifying file $NAME..."
DECIMAL=$(echo "$((2#$PERMS))") # converting binary permissions into decimal number for chmod
chmod "$DECIMAL"00 "$NAME" #keep other digits 0 since we want to restrict groups and other users
ls -l $NAME #Verify that the permissions are correct
