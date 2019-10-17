#!/usr/bin/env bash

#set -e


target_tag=v2.0.2

official_repo=cosmos_gaia

#git remote remove $official_repo
git remote add $official_repo https://github.com/cosmos/gaia

# pull $official_repo branch info
git fetch $official_repo


git checkout $target_tag

# push
git push origin $target_tag
