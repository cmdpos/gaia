#!/bin/bash


export FABRIC_PATH=github.com/abchain/fabric
export FABRIC_TOP=${GOPATH}/src/${FABRIC_PATH}

cd $FABRIC_TOP/tools/dbutility/dbscan
./scandb.sh 0 > $FABRIC_TOP/wkdir/dbvp0.json
./scandb.sh 1 > $FABRIC_TOP/wkdir/dbvp1.json
./scandb.sh 2 > $FABRIC_TOP/wkdir/dbvp2.json
./scandb.sh 3 > $FABRIC_TOP/wkdir/dbvp3.json
