#!/usr/bin/env bash

docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

docker rmi $(docker images | grep hyperledger/yafabric-src | awk '{print $3}') -f