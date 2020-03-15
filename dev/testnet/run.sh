#!/bin/bash

../killbyname.sh "gaiacli rest-server"
../killbyname.sh "gaiad"
../killbyname.sh "okchaind"
../killbyname.sh "evaiod"

./testnet.sh -i -s -n 4

#nohup gaiacli rest-server --laddr tcp://localhost:10059 --node tcp://localhost:10157 &


for ((;;)) do
    tail -n 5 ./cache/evaiod.0.log
    tail -n 5 ./cache/evaiod.1.log
    tail -n 5 ./cache/evaiod.2.log
    tail -n 5 ./cache/evaiod.3.log
    sleep 5
done

