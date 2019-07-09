#!/usr/bin/env bash
lsof -i -n -P|grep $1
