#!/usr/bin/env bash

export GO111MODULE=on
export GOPROXY=http://goproxy.io
go mod tidy
go mod vendor

exit
export GO111MODULE=off
make install
