#!/usr/bin/env bash

git remote -v|grep fetch|awk '{print "git clone " $2}'|sh


git config --global user.email "zhongqiuwood@gmail.com"
git config --global user.name "zhongqiuwood"