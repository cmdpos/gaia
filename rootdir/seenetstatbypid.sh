#!/usr/bin/env bash
lsof -p $1 -P|grep TCP
