#!/usr/bin/env bash


docker rmi $(docker images | grep $1 | awk '{print $3}') -f