#!/usr/bin/env bash


./killbyname.sh "evaiocli rest-server"
./killbyname.sh "evaiod"
./killbyname.sh "okchaind"
#rm -rf ~/.evaiod

rm nohup.out

(cd .. && make install)

#rm -rf cache

#evaiod testnet --v 1 --output-dir cache --chain-id testchain --starting-ip-address 127.0.0.1<<EOF
#12345678
#EOF

evaiocli config chain-id evaio
evaiocli config trust-node true
evaiocli config output json
evaiocli config indent true

sleep 1
#nohup evaiocli rest-server &
nohup evaiod start --home cache --p2p.seeds 7b25b5163db6e68c506305a864fe9a27d6c8e2ed@47.99.211.214:30180 &

