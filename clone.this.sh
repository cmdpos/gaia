#!/usr/bin/env bash

git remote -v|awk '{print "git clone " $2}'| sh