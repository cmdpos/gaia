#!/usr/bin/env bash

set -e

target_branch=release/v2.0.1

git remote remove okcoin
git remote add okcoin git@gitlab.okcoin-inc.com:dex/gaia.git

# pull okcoin branch info
git fetch okcoin

# go to official master
git checkout remotes/offi/$target_branch


#git branch -D $target_branch

# create a local branch
git checkout -b $target_branch

# push official master commit history to okcoin master
git push --set-upstream okcoin $target_branch