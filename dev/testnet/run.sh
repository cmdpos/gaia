#!/bin/bash

../killbyname.sh "gaiacli rest-server"
../killbyname.sh "gaiad"
../killbyname.sh "okchaind"
../killbyname.sh "evaiod"
rm -rf ~/.evaiod

./testnet.sh -i -s -n 4

for ((;;)) do
    tail -n 5 ./cache/evaiod.0.log
    tail -n 5 ./cache/evaiod.1.log
    tail -n 5 ./cache/evaiod.2.log
    tail -n 5 ./cache/evaiod.3.log
    sleep 5
done

