#!/bin/bash

##################################################################
# start.sh: Walletデーモンを起動する
# [引数]
# ・$1: 設定ファイルパス
#       設定ファイルはenv.sh.sampleを参照
# [Example]
# ・起動: ./start.sh /home/wallet/xxcoin/env.sh
##################################################################

if [ -z "${1}" -o ! -f "${1}" ]; then
    echo "env-file is invalid."
    exit 1
fi

source ${1}

if [ -n "${ENV_LIB}" ]; then
    eval "LD_LIBRARY_PATH=${ENV_LIB} ${ENV_DAEMON}"
else
    eval "${ENV_DAEMON}"
fi

