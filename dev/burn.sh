#!/usr/bin/env bash


#gaiacli tx token issue -t btc -n 1000 -w btc --from node0 --fees 10000000000neva -yes -b block <<EOF
#12345678
#EOF


#gaiacli tx token issue -t btc -n 1000 -w btc --from node0 --fees 10000000000neva -yes -b block <<EOF
#12345678
#EOF
#
#

gaiacli tx token burn 10000neva,90node0token --from node0  -yes -b block

gaiacli query account eva1hg40dv5e237qy28vtyum52ygke32ez35syykpz
gaiacli query supply total
