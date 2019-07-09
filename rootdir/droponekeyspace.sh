#!/bin/bash

echo "clear data on cassandra:"
cqlsh master 8266 -e "drop keyspace $1;"

echo "clear data on ssdb:"
echo "hclear $1" | /root/qzhong/cdcproj/ssdb-master/tools/ssdb-cli cdc1
echo ""
