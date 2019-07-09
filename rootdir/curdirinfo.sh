#!/usr/bin/env bash
du -ms $1/*|sort -k 1n
df
