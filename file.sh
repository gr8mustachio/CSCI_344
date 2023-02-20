#!/bin/bash
touch myfile.txt
> myfile.txt # Clearing file contents if it already exists
for i in {1..1000}
do
    echo $i >> myfile.txt # populating file with values
done

# Splitting file
head -n 200 myfile.txt > f1.txt
head -n 400 myfile.txt | tail -200 > f2.txt
head -n 600 myfile.txt | tail -200 > f3.txt
head -n 800 myfile.txt | tail -200 > f4.txt
head -n 1000 myfile.txt | tail -200 > f5.txt
> myfile.txt # clear file to allow for repopulation without the middle chunk
# repopulating...
cat f1.txt >> myfile.txt
cat f2.txt >> myfile.txt
cat f4.txt >> myfile.txt
cat f5.txt >> myfile.txt
