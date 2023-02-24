#!/bin/bash

exit 99 # setting return value
echo "$?"

if [ "$?" -gt 0 ]; then
	echo "ERROR, NOT SUCCESSFUL"
else
	echo "SUCCESS"
fi
