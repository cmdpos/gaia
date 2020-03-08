#!/bin/bash


CUR_DIR=`pwd`


CHAIN_NODE="--node tcp://localhost:10057"


echorun(){
    echo "--------------------------------------------------------------"
    echo "<"$@">"
    $@
}
loop_nodes() {
    for (( i=0; i<${1}; i++)) do
        if [ -d cache/node${i} ]; then
            echo "===========================node${i} account details=================================="
            CHAIN_HOME="--home ${CUR_DIR}/cache/node${i}/gaiacli"
            CHAIN_ENV0="--node tcp://localhost:10057 --home cache/node${i}/gaiacli --chain-id testchain"

            delegater_address=$(gaiacli keys show node${i} -a ${CHAIN_HOME})
            operator_address=$(gaiacli keys show node${i} --bech val -a ${CHAIN_HOME})
            conspub=$(gaiad tendermint show-validator --home cache/node${i}/gaiad)

            echorun gaiacli query account $delegater_address ${CHAIN_ENV0}
            echorun gaiacli query staking validator $operator_address ${CHAIN_ENV0}

            echorun gaiacli query distribution rewards $delegater_address ${CHAIN_ENV0}
            echorun gaiacli query distribution commission $operator_address ${CHAIN_ENV0}
            echorun gaiacli query distribution validator-outstanding-rewards $operator_address ${CHAIN_ENV0}
            echorun gaiacli query distribution slashes $operator_address 0 9999999999999 ${CHAIN_ENV0}

            echorun gaiacli query slashing signing-info $conspub ${CHAIN_ENV0}

        fi
    done
}


loop_nodes 4
