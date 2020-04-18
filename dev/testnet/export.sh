#!/usr/bin/env bash


index=$1


evaiod export --for-zero-height  --home cache/node${index}/evaiod | jq > node$index.json