#!/bin/bash

 
# Step 1
echo Step 1
dd if=/dev/zero of=/home/ltsmith/largefile.txt bs=1M count=9
ls -l /home/ltsmith/largefile.txt


# Step 2
echo Step 2
ls /home/ > allUsers.txt
ls -la allUsers.txt


> fout.txt
# Step 3
FILE="$(cat allUsers.txt)"
for line in $FILE; do
    if [ "$line" = "lost+found" ]; then
        echo not this one
    else
        DIR=$(du -s /home/"$line" 2>/dev/null)
        PREFIX='/home/'
        USER=${DIR//$PREFIX/} # making it so it only displays the bytes followed by the user without the /home/
                              # prefix
        # CSV_USER=echo $USER | tr ' ' ','  # I was stuck on this for a while, my workaround is to have each key/value pair paired by a comma and separated by a space so I can parse the data correctly in the following steps
        echo $USER"," >> fout.txt
    fi
done


# Step 4-5
FILE="$(cat fout.txt)"
declare -A USERARRAY=()

while IFS="," read -r line; do
    NAME=$(echo $line | awk -F " "  "{print $2}")
    SPACE=$(echo $line | awk -F ' ' "{print $1}") 
    SPACE=${SPACE//[!0-9]/}
    echo $NAME
done < fout.txt


#for line in $FILE; do
    # NAME=$(awk "{printf $2}" fout.txt) # isolating names by removing numeric values from string
    # NAME=${line//[[:digit:]]/} # isolating names by removing numeric values from string
    # SIZE=${line//[!0-9]/} # isolating size by only removing non-numeric values
    # ID=$(id -u "$NAME")
    # if [ $ID =~ [0-9] ]; then 
    # echo "$ID, $SIZE"
    # USERARRAY[$ID]=$SIZE
    #fi
# done

# Checking contents
for i in "${!USERARRAY[@]}"; do
    echo ${USERARRAY[$i]}" "$i
done

# Step 6
touch arrayFile.txt
> arrayFile.txt
for i in "${!USERARRAY[@]}"; do
    echo ${USERARRAY[$i]}" "$i >> arrayFile.txt
done

# Step 7, implementing my sorting array
