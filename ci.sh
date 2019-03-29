#!/usr/bin/env bash
git add .
git commit -m upd
git push

git remote -v|awk '{print "git clone " $2}'| sh