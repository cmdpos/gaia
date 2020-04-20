#!/usr/bin/env bash



evaiod unsafe-reset-all --home ../cache/node0/evaiod

./migrate.sh
cp 36state.json ../cache/node0/evaiod/config/genesis.json

evaiod start --home ../cache/node0/evaiod

exit
# 在主网每个节点上执行以下命令

# 确保evaiod版本是2.0.8
# $ evaiod version
# 2.0.8

##  节点当前evaiod的home
old_home=$1

##  升级后evaiod的home
new_home=$2

## 经过migrate处理过的主网状态文件
state_file=$3


## 这两步非常重要，目的是保持
# evaiod/config/app.json
# evaiod/config/config.json
# evaiod/config/node_key.json
# evaiod/config/priv_validator_key.json
# 等文件和升级前完全一致
# 并重置evaiod/data/priv_validator_state.json
cp -rf $old_home $new_home
evaiod unsafe-reset-all --home $new_home


## 把经过migrate处理过的主网状态文件放到升级后evaiod的home里
cp $state_file $new_home/config/genesis.json

## 用升级后evaiod的home启动新的链
evaiod start --home $new_home