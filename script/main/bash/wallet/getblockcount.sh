#!/bin/bash

######################################################################
# getblockcount.sh
# 
# [Description]
#  ブロックチェーンのブロック数を取得する。
# 
# [Arguments]
#  * $1: 設定ファイルパス
#        設定ファイルはwallet.settings.sampleを参照
# 
# [Example]
#  * ./getblockcount.sh /wallet/xxcoin/wallet.settings
# 
######################################################################

if [ -z "${1}" -o ! -f "${1}" ]; then
    echo "Settings-file is invalid."
    exit 100
fi

source "${1}"
source "${ENV_CONFIG}"

eval '"${ENV_CMD_DIR}/${CF_CMD}" "${1}" getblockcount'
exit $?

