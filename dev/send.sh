#!/usr/bin/env bash

#evaio tx send cosmos15fypuqpfvkdgg590u6phdq9ts6ag50dqz38nxf 1stake \
#--from node0 --home catch/node0/evaio \
#--memo "hqeiurh qeiu hqeiur hqeiur qieuv gqeiurvqei uvqiuvqeifuvqiuhvqieuvwpiuvhw" \
#--chain-id testchain --fees 2stake -y <<EOF
#12345678
#EOF


evaiocli tx send node0 eva1geyy4wtak2q9effnfhze9u4htd8yxxma0jmgl6 20000000000neva --fees 10000000000neva -yes -b block<<EOF
12345678
EOF

evaiocli query account eva1hg40dv5e237qy28vtyum52ygke32ez35syykpz

