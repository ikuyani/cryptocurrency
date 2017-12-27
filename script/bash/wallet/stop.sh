#!/bin/bash

##################################################################
# stop.sh: Walletデーモンを停止する
# [引数]
# ・$1: 設定ファイルパス
#       設定ファイルはenv_wallet.sh.sampleを参照
# [Example]
# ・停止: ./stop.sh /home/wallet/xxcoin/env_wallet.sh
##################################################################

if [ -z "${1}" -o ! -f "${1}" ]; then
    echo "env-file is invalid."
    exit 1
fi

source ${1}

eval "${ENV_CMD_SH} ${1} stop"


