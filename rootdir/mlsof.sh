#!/bin/csh
if ($# == 0) then
    echo "Please input PID first..."
    exit
endif

@ sampling=600
set sdate=""
set filenum=""
set portnum=""



while (2>1)
    set sdate=`date +%Y_%m_%d_%H_%M_%S`
    set filenum=`lsof -p $1 | grep -c " "`
    set portnum=`netstat -plan | grep $1 | grep -c " "`

    #lsof.sh > $sdate.$1.log
    sudo lsof -p $1 >$sdate.$1.log
	    sleep $sampling
end


while (2>1)
    set sdate=`date +%Y_%m_%d_%H_%M_%S`
    set filenum=`lsof -p $1 | grep -c " "`
    set portnum=`netstat -plan | grep $1 | grep -c " "`
    echo "date="$sdate "pid="$1 "lsof>>>"$filenum "netstat>>>"$portnum 
    sleep $sampling
end

