#!/usr/bin/env bash

PEERADDRBASE=7055
EVENTADDRBASE=7053
FILEPATHBASE=/var/hyperledger

BRIDGE_URL=127.0.0.1:7055
ROOTNODE1_URL=127.0.0.1:7155
ROOTNODE2_URL=127.0.0.1:7255

# ns1:
# ns2:
# bridge:
#61709 ttys001    0:00.16 ./txnetwork_0_brigde
#61712 ttys001    0:00.15 ./txnetwork_1_ns1
#61716 ttys001    0:00.18 ./txnetwork_2_ns2
#61719 ttys001    0:00.16 ./txnetwork_3_i1
#61722 ttys001    0:00.15 ./txnetwork_4_i2
#61725 ttys001    0:00.14 ./txnetwork_5_e1
#61728 ttys001    0:00.12 ./txnetwork_6_e2



function startpeer {

    index=$1
    name=$2
    rootnode=$3
    discovery_hidden=$4
    discovery_disable=$5

    ((ADDRPORT = PEERADDRBASE + index * 100))
    ((EVENTADDRPORT = EVENTADDRBASE + index * 100))

    export CORE_PEER_LISTENADDRESS=127.0.0.1:${ADDRPORT}
    export CORE_PEER_ADDRESS=${CORE_PEER_LISTENADDRESS}
    export CORE_PEER_ID=${index}_${name}
    export CORE_PEER_VALIDATOR_EVENTS_ADDRESS=127.0.0.1:${EVENTADDRPORT}
    export CORE_PEER_FILESYSTEMPATH=${FILEPATHBASE}/txnet${index}
    export CORE_PEER_DISCOVERY_ROOTNODE=${rootnode}
    export CORE_PEER_DISCOVERY_HIDDEN=${discovery_hidden}
    export CORE_PEER_DISCOVERY_DISABLE=${discovery_disable}

#	discoveryHidden = viper.GetBool("peer.discovery.hidden")
#	discoveryDisable = viper.GetBool("peer.discovery.disable")

    export LOG_STDOUT_FILE=_stdout_txnetwork_$1_$2.json
    echo Run node ${CORE_PEER_ADDRESS} ...
    cp txnetwork txnetwork_${CORE_PEER_ID}
    ./txnetwork_${CORE_PEER_ID} >> ${LOG_STDOUT_FILE} 2>>${LOG_STDOUT_FILE} &
    #sleep 1
}


function main {
    go build
    ./killbyname.sh txnetwork
    rm ./txnetwork_*
    rm -rf ${FILEPATHBASE}/txnet*
    rm *_stdout_*_*.json
    startpeer 0 brigde ${ROOTNODE1_URL},${ROOTNODE2_URL} false true
    startpeer 1 ns1 "" true false
    startpeer 2 ns2 "" true false
    startpeer 3 i1 ${ROOTNODE1_URL} false false
    startpeer 4 i2 ${ROOTNODE1_URL} false false
    startpeer 5 e1 ${ROOTNODE2_URL} false false
    startpeer 6 e2 ${ROOTNODE2_URL} false false

#    for ((index=0; index<$1; index++)) do
#        startpeer ${index}
#    done
}

main $1
