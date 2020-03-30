#!/usr/bin/env bash


gaiacli tx token issue -t btc -n 1000 -w btc --from node0 --fees 10000000000neva -yes -b block <<EOF
12345678
EOF


gaiacli tx token issue -t btc -n 1000 -w btc --from node0 --fees 10000000000neva -yes -b block <<EOF
12345678
EOF


gaiacli tx token burn -t neva -n 50 --from node0
