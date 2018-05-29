#!/bin/bash

echo "clear data on ssdb:"
echo "hclear $1" | /root/qzhong/cdcproj/ssdb-master/tools/ssdb-cli cdc1
echo ""
