#!/usr/bin/env bash

set -e


target_branch=release/v2.0.2

official_repo=cosmos_gaia

#git remote remove $official_repo
git remote add $official_repo https://github.com/cosmos/gaia

# pull $official_repo branch info
git fetch $official_repo

# go to official master
git checkout remotes/$official_repo/$target_branch


#git branch -D $target_branch

# create a local branch
git checkout -b $target_branch

# push official master commit history to $official_repo master
git push --set-upstream origin $target_branch