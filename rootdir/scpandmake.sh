#!/bin/bash
LOCAL_XMR_SRC_TOP=/Users/zhongqiu/xmr
REMOTE_XMR_SRC_TOP=/mnt/qzhong/xmr

scp -r $LOCAL_XMR_SRC_TOP/src/simplewallet/simplewallet.h root@cdc6:$REMOTE_XMR_SRC_TOP/src/simplewallet
scp -r $LOCAL_XMR_SRC_TOP/src/wallet/wallet2.h root@cdc6:$REMOTE_XMR_SRC_TOP/src/wallet

scp -r $LOCAL_XMR_SRC_TOP/src/simplewallet/simplewallet.cpp root@cdc6:$REMOTE_XMR_SRC_TOP/src/simplewallet
scp -r $LOCAL_XMR_SRC_TOP/src/wallet/wallet2.cpp root@cdc6:$REMOTE_XMR_SRC_TOP/src/wallet

#$LOCAL_XMR_SRC_TOP/hook.sh 6 "cd $REMOTE_XMR_SRC_TOP && make cli -j"&
exit
