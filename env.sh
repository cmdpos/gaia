#!/usr/bin/env bash

alias rzy='rz -y -e -b'
alias dum='du -ms'
alias ll='ls -l'
alias ldd='otool -L'
alias lla='ls -la'
alias llrt='ls -ltr'
export ENV_LOCAL_HOST_IP=192.168.168.86
export ZILLIQA_BUILD_TOP=/Users/oak/go/src/github.com/zhongqiuwood/Zilliqa/build
export KAFKA_HOME=/usr/local/kafka
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_172.jdk/Contents/Home


#export CORE_LEDGER_STATE_DATASTRUCTURE_CONFIGS_NUMBUCKETS=32
#export CORE_LEDGER_STATE_DATASTRUCTURE_CONFIGS_MAXGROUPINGATEACHLEVEL=3

export COIN_DEPS=/Users/oak/oklab/test/libsodium-stable
export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
export NVM_DIR=/Users/$LOGNAME/.nvm
export PYTHONIOENCODING=UTF-8
export GRAPHVIZ_DOT=/usr/local/bin/dot
export OPENSSL_ROOT_DIR=/usr/local/opt/openssl
export OPENSSL_CRYPTO_LIBRARY=/usr/local/opt/openssl/lib

export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH=/Users/$LOGNAME/lib/nwjs-v0.14.7-osx-x64/nwjs.app/Contents/MacOS:$PATH
export PATH=/usr/local/opt/python/libexec/bin:$PATH
export PATH=$GOPATH/bin:$GOBIN:$KAFKA_HOME/bin:$SSDB_HOME/bin:$PATH
export PATH=/Users/$LOGNAME/lib/scrp/phantomjs-2.1.1-macosx/bin:$PATH
export PATH=/User/$LOGNAME/code/bin:$PATH
export PATH=/usr/local/opt/qt/bin:$PATH
export PATH=/Users/oak/go/src/github.com/hyperledger/fabric/.build/bin:/usr/local/Cellar/python@2/2.7.15/bin:$GOPATH/bin:$GOBIN:$KAFKA_HOME/bin:$SSDB_HOME/bin:$PATH
export PATH=$KAFKA_HOME/bin:$SSDB_HOME/bin:$PATH
