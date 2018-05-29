#!/bin/bash
ssh root@cdc$1 << eeooff
#ps -ef|grep python
$2
#/home/cdc/sbin/seepy.sh
exit
eeooff
