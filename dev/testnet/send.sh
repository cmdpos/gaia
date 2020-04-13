#!/bin/bash


#addr: [eva1hg40dv5e237qy28vtyum52ygke32ez35syykpz]
#secret: [depart neither they audit pen exile fire smart tongue express blanket burden culture shove curve address together pottery suggest lady sell clap seek whisper]
#
#nodeDirName: [node1]
#clientDir: [cache/node1/gaiacli]
#addr: [eva1geyy4wtak2q9effnfhze9u4htd8yxxma0jmgl6]

#gaiacli tx send $(gaiacli keys show node2 --home cache/node2/gaiacli -a) 100000000stake \
#    --from node3 --node localhost:10057 --chain-id testchain -y --home cache/node3/gaiacli --fees 6000000stake



gaiacli tx send node0 eva1geyy4wtak2q9effnfhze9u4htd8yxxma0jmgl6 1neva  \
 -yes -b block --node tcp://localhost:10057 \
 --gas auto --fees 2100000000neva

gaiacli query account eva1hg40dv5e237qy28vtyum52ygke32ez35syykpz --node tcp://localhost:10057
#gaiacli tx send cosmos1geyy4wtak2q9effnfhze9u4htd8yxxmagdw3q0 26000000stake --from 307 --fees 6000000stake -yes --node localhost:10057