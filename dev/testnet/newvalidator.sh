#!/usr/bin/env bash

#./recover.sh

index=$1

evaiocli keys add node${index} -y --home cache/node${index}/evaiocli<<EOF
12345678
12345678
EOF

toAddr=$(evaiocli keys show node${index} -a --home cache/node${index}/evaiocli)
valPubkey=$(gaiad tendermint show-validator --home cache/node${index}/evaiocli)


echorun(){
    echo "["$@"]"
    $@
}

echorun evaiocli tx send node0 $toAddr 100000000000neva -b block --yes --chain-id testchain --node tcp://localhost:10057

sleep 10

evaiocli tx staking create-validator --amount 10000000000neva \
    --pubkey ${valPubkey} \
    --chain-id testchain --commission-rate 0.1 \
    --commission-max-rate 0.5 \
    --commission-max-change-rate 0.001 \
    -b block \
    --min-self-delegation 1 --from node${index} --moniker node${index} -y --node tcp://localhost:10057 \
    --home cache/node${index}/evaiocli
