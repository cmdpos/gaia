#!/bin/csh
if ($# == 0) then
    echo "Please input PID first..."
    exit
endif

@ index=0
@ sampling=600
set sdate=""
set smem=""
while (2>1)
    set sdate=`date +%Y_%m_%d_%H_%M_%S`
    set smem=`ps -e -o user -o pid -o ppid -o comm -o pcpu -o rss -o vsz| grep $1`
    @ index++
    echo $index "date="$sdate "pid="$1 "info>>>"$smem
    sleep $sampling
end
