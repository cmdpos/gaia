#!/usr/bin/env bash

git remote add okcoin git@gitlab.okcoin-inc.com:dex/gaia.git

# pull okcoin branch info
git fetch okcoin

# list all remote branch
git branch -a

# go to official master
git checkout remotes/offi/master

# push official master commit history to okcoin master
git push --set-upstream okcoin master