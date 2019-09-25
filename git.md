## add a remote repo

git remote add upstream https://github.com/monero-project/monero 

git checkout remotes/upstream/master

git checkout -b offmaster

## git branch --set-upstream-to=upstream/master offmaster
make upstream/master as the upstream of local branch offmaster 

## git push --set-upstream origin patched
create a branch named patched on origin repo, then make origin/patched as the upstream of local branch patched 
