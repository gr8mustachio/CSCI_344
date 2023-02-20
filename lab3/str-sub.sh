#!/bin/bash
WHERE_LS=$(whereis ls | awk '{print $2}')
WHERE_LS=${WHERE_LS//'/ls'/}
echo ":$WHERE_LS";
echo '$WHERE_LS'
export PATH=$(echo $PATH | sed -e "s%\(:$WHERE_LS).*%%" )
PATH2=${PATH//':WHERE_LS'/}
echo "Path2: $PATH2"
echo "Path1: $PATH"
