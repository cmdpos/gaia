#!/usr/bin/env bash

alias rzy='rz -y -e -b'
alias dum='du -ms'
alias ll='ls -l'
alias ldd='otool -L'
alias lla='ls -la'
alias llrt='ls -ltr'
export GO111MODULE=off
export ETCDCTL_API=3
#export CC1="--node c21:26657"
#export CC2="--node c22:26657"
#export CC3="--node c23:26657"
#export CC4="--node c24:26657"
#export CC5="--node c25:26657"
#export CCC="--node c16:26657"
#export CC13="--node c13:26657"

export KAFKA_HOME=/usr/local/kafka
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home

#export CORE_LEDGER_STATE_DATASTRUCTURE_CONFIGS_NUMBUCKETS=32
#export CORE_LEDGER_STATE_DATASTRUCTURE_CONFIGS_MAXGROUPINGATEACHLEVEL=3

export COIN_DEPS=/Users/oak/oklab/test/libsodium-stable
export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
export NVM_DIR=/Users/$LOGNAME/.nvm
export PYTHONIOENCODING=UTF-8
export GRAPHVIZ_DOT=/usr/local/bin/dot
export OPENSSL_ROOT_DIR=/usr/local/opt/openssl
export OPENSSL_CRYPTO_LIBRARY=/usr/local/opt/openssl/lib
export GOPATH=/Users/$LOGNAME/go
export GOBIN=$GOPATH/bin
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH=/Users/$LOGNAME/lib/nwjs-v0.14.7-osx-x64/nwjs.app/Contents/MacOS:$PATH
export PATH=/usr/local/opt/python/libexec/bin:$PATH
export PATH=$GOBIN:$KAFKA_HOME/bin:$PATH
export PATH=/Users/$LOGNAME/lib/scrp/phantomjs-2.1.1-macosx/bin:$PATH
export PATH=/User/$LOGNAME/code/bin:$PATH
export PATH=/opt/apache-maven-3.6.3/bin:/usr/local/opt/qt/bin:$PATH
export PATH=/Users/oak/go/src/github.com/hyperledger/fabric/build/bin:/usr/local/Cellar/python@2/2.7.15/bin:$PATH
