#!/usr/bin/env bash


./killbyname.sh "evaiocli rest-server"
./killbyname.sh "evaiod"
./killbyname.sh "okchaind"
./killbyname.sh "evaiod"
#rm -rf ~/.evaiod

rm nohup.out

(cd .. && make install)

#rm -rf cache

#evaiod testnet --v 1 --output-dir cache --chain-id testchain --starting-ip-address 127.0.0.1<<EOF
#12345678
#EOF

evaiocli config chain-id testchain
evaiocli config trust-node true
evaiocli config output json
evaiocli config indent true

sleep 1
#nohup evaiocli rest-server &
evaiod start --home cache/node0/evaiod

