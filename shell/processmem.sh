#!/bin/csh
if ($# == 0) then
    echo "Please input PID first..."
    exit
endif

@ index=0
@ sampling=$2
set sdate=""
set smem=""
while (2>1)
    set sdate=`date +%Y_%m_%d_%H_%M_%S`
    set osmem=`free -m| grep Mem`
    set smem=`ps -e -o user -o pid -o ppid -o comm -o pcpu -o rss -o vsz| grep $1`
    @ index++
    echo $index". "$sdate": pid["$1"]<"$smem">, os<"$osmem">"
    sleep $sampling
end
