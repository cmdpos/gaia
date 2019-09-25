## add a remote repo

git remote add upstream https://github.com/monero-project/monero 

git checkout remotes/upstream/master

git checkout -b offmaster

git branch --set-upstream-to=upstream/master offmaster
