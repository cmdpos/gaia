#!/bin/sh
echo "established"
while [ "1" = "1" ]
do
netstat -nat | grep ESTABLISHED | grep $1 | wc -l
sleep 600
done
