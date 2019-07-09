#!/bin/sh
echo "unestablished"
while [ "1" = "1" ]
do
netstat -nat | grep SYN_RECV | grep $1 | wc -l
sleep 2
done
