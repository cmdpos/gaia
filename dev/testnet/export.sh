#!/usr/bin/env bash


index=$1


gaiad export --for-zero-height  --home cache/node${index}/gaiad > node$index.json