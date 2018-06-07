#!/bin/bash

rm -rf /var/hyperledger/production*

cp -rf ~/__var_hy2/production* /var/hyperledger/

#exit

./runyafabric.sh -f 1 -c p -r clearlog
sleep 3

./invoke.sh i
