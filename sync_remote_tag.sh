#!/usr/bin/env bash

#set -e


target_tag=$1

official_repo=cosmos_gaia

has_tag=`git tag | grep ${target_tag}`
if [[ $has_tag != "" ]];then
    git checkout $target_tag
    echo "error: exist gaia tag ${target_tag}"
    exit
fi
#git remote remove $official_repo
git remote add $official_repo https://github.com/cosmos/gaia

# pull $official_repo branch info
git fetch $official_repo


git checkout $target_tag

# push
git push origin $target_tag
