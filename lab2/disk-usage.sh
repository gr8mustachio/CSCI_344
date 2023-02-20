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
    # had to do error handling, no clue who 'aher' is but they caused me a massive headache by not being an actual user and screwing up my program, glad I figured it out
    if [ "$line" = "lost+found" ] || [ "$line" = "aher" ]; then
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
declare -a USERARRAY=()

# This took me forever to figure out, I was stuck for a while before I realized it would be way easier to use a while loop with the read command instead of a for loop 
while IFS="," read -r line; do
    NAME=$(echo $line | awk -F ' ' '{print $2}') 
    SPACE=$(echo $line | awk -F ' ' '{print $1}')
    ID=$(id -u $NAME)
    SPACE=${SPACE//[!0-9]/} # isolating size by only removing non-numeric values
    ID=${ID//[!0-9]/}
    USERARRAY[$ID]=$SPACE
done < fout.txt
# Checking contents

# Step 6
touch arrayFile.txt
> arrayFile.txt
for i in "${!USERARRAY[@]}"; do
    echo ${USERARRAY[$i]}  >> arrayFile.txt
done

# Step 7
sort -h arrayFile.txt > sorted.txt
i=1
upper=1
while read -r line; do
    if [ $line -lt 8000 ]; then
        ((upper=$upper+1))
    fi
    i=i+1
done < sorted.txt
#Step 8
sed -i 1,"$upper"d sorted.txt
tail -3 sorted.txt
