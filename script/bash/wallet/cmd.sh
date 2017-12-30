#!/bin/bash

##################################################################
# cmd.sh: ウォレットコマンド(client API)を実行する
# [引数]
# ・$1: 設定ファイルパス
#       設定ファイルはwallet.settings.sampleを参照
# ・$2: 実行するコマンド
# ・$3以降: コマンドに渡す引数
# [Example]
# ・停止: ./cmd.sh /home/wallet/xxcoin/wallet.settings stop
# ・ヘルプ: ./cmd.sh /home/wallet/xxcoin/wallet.settings help getinfo
##################################################################

if [ -z "${1}" -o ! -f "${1}" ]; then
    echo "Settings is invalid."
    exit 1
fi

source ${1}

v_arg=
v_count=1
for i in "${@}"
do
    if [ ! ${v_count} -eq 1 ]; then
        v_arg="${v_arg} ${i}"
    fi
    v_count=$(expr $v_count + 1)
done

if [ -n "${ENV_LIB}" ]; then
    eval "LD_LIBRARY_PATH=${ENV_LIB} ${ENV_CLIENT} ${v_arg}"
else
    eval "${ENV_CLIENT} ${v_arg}"
fi

