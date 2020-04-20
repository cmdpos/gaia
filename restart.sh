#!/usr/bin/env bash


./dev/killbyname.sh "evaiocli rest-server"
./dev/killbyname.sh "evaiod"
./dev/killbyname.sh "okchaind"
./dev/killbyname.sh "evaiod"
rm -rf ~/.evaiod
rm nohup.out
rm -rf dev/cache

make install


evaiod testnet --v 1 --output-dir dev/cache --chain-id testchain --starting-ip-address 127.0.0.1

evaiocli config chain-id testchain
evaiocli config trust-node true
evaiocli config output json
evaiocli config indent true

sleep 1
evaiod start --home dev/cache/node0/evaiod

