#!/bin/bash

######################################################################
# start.sh
# 
# [Description]
#  ウォレットを起動する。
# 
# [Arguments]
#  * $1: 設定ファイルパス
#        設定ファイルはwallet.settings.sampleを参照
# 
# [Example]
#  * 起動: ./start.sh /wallet/xxcoin/wallet.settings
# 
######################################################################

if [ -z "${1}" -o ! -f "${1}" ]; then
    echo "Settings-file is invalid."
    exit 100
fi

source "${1}"

if [ -n "${ENV_LIB}" ]; then
    eval 'LD_LIBRARY_PATH="${ENV_LIB}" "${ENV_DAEMON}"'
    exit $?
else
    eval "${ENV_DAEMON}"
    exit $?
fi

