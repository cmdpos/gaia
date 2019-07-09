#!/bin/csh
@ index=0
@ sampling=$1
set sdate=""
set smem=""
while (2>1)
    set sdate=`date +%Y_%m_%d_%H_%M_%S`
    set smem=`free -m| grep Mem`
    @ index++
    echo $index "date="$sdate "os mem info>>>"$smem
    sleep $sampling
end
