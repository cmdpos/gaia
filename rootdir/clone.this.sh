#!/usr/bin/env bash

git remote -v|grep fetch|awk '{print "git clone " $2}'|sh
