#!/bin/bash

######################################################################
# encryptwallet.sh
# 
# [Description]
#  ウォレットを暗号化する。
#  暗号化のためのパスフレーズは対話式で入力する。
#  スペースを含む場合、ダブルクォーテーション(")等で囲まないこと。
# 
# [Arguments]
#  * $1: 設定ファイルパス
#        設定ファイルはwallet.settings.sampleを参照
# 
# [Example]
#  * ./encryptwallet.sh /wallet/xxcoin/wallet.settings
# 
######################################################################

if [ -z "${1}" -o ! -f "${1}" ]; then
    echo "Settings-file is invalid."
    exit 100
fi

source "${1}"
source "${ENV_CONFIG}"

echo "ウォレットを暗号化します。"
echo "暗号化すると一部の処理でパスフレーズが必要になります。"
echo "継続しますか？[Y/N]"
read v_yesno
if [ "${v_yesno,,}" != "yes" -a "${v_yesno,,}" != "y" ]; then
    echo "ウォレットを暗号化せずに終了します。"
    exit ${CF_ERR_ENCRYPTWALLET_CANCEL}
fi

echo "暗号化するためのパスフレーズを入力してください。"
read v_passphrase1
echo "確認のため再度パスフレーズを入力してください。"
read v_passphrase2

if [ "${v_passphrase1}" != "${v_passphrase2}" ]; then
    echo "1回目と2回目のパスフレーズが異なります。"
    echo "ウォレットを暗号化せずに終了します。"
    exit ${CF_ERR_ENCRYPTWALLET_PASSPHRASE}
fi

if [ -n "${ENV_LIB}" ]; then
    eval 'LD_LIBRARY_PATH="${ENV_LIB}" "${ENV_CLIENT}" encryptwallet "${v_passphrase1}"'
    exit $?
else
    eval '"${ENV_CLIENT}" encryptwallet "${v_passphrase1}"'
    exit $?
fi

