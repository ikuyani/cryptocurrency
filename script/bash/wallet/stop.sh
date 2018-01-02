#!/bin/bash

######################################################################
# stop.sh
# 
# [Description]
#  ウォレットを停止する。
# 
# [Arguments]
#  * $1: 設定ファイルパス
#        設定ファイルはwallet.settings.sampleを参照
# 
# [Example]
#  * 停止: ./stop.sh /wallet/xxcoin/wallet.settings
# 
######################################################################

if [ -z "${1}" -o ! -f "${1}" ]; then
    echo "env-file is invalid."
    exit 1
fi

source "${1}"
source "${ENV_CONFIG}"

eval "${ENV_CMD_DIR}/${CF_CMD} ${1} stop"

