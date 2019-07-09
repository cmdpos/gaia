#!/bin/bash

if [ -f core/task_controller/info.txt ]; then
    rm core/task_controller/info.txt
fi
scp -r sbin root@cdc$1:/home/cdc/
scp -r crawler root@cdc$1:/home/cdc/
scp -r core/task_controller root@cdc$1:/home/cdc/
