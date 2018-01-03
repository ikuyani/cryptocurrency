#!/bin/bash

######################################################################
# zaif_getpublicdata.sh
#
# [Description]
#  CoincheckのPublic APIのデータを取得する。
#  実行にはwgetが必要。
#
# [Arguments]
#  * $1: 設定ファイルパス
#        設定ファイルはzaif.settings.sampleを参照
#  * $2: 出力ファイルのシリアルナンバー
#
# [Example]
#  ./zaif_getpublicdata.sh ./zaif.settings.sample
#
######################################################################

if [ -z "${1}" -o ! -f "${1}" ]; then
    echo "Settings[${1}] is invalid."
    exit 1
fi

source "${1}"

if [ ! -f "${ENV_ZAIF_CONFIG}" ]; then
    echo "Config[${ENV_ZAIF_CONFIG}] is invalid."
    exit 1
fi

source "${ENV_ZAIF_CONFIG}"

v_sno=${2}
if [ -z "${v_sno}" ]; then
    v_sno=`date "+%Y%m%d%H"`
fi

# currencies 通貨情報 /currencies/{currency}
if [ -n "${ENV_ZAIF_API_CURRENCIES_FLG}" ]; then
v_err=0
v_dir="${ENV_ZAIF_API_CURRENCIES_DIR}"

if [ -d "${v_dir}" ]; then
    v_err=0

elif [ -e "${v_dir}" ]; then
    echo "${v_dir} is exist, and not a directory."
    v_err=1

else
    mkdir -p "${v_dir}"
    if [ $? -ne 0 ]; then
        echo "${v_dir} create failed."
        v_err=1
    fi
fi

if [ ${v_err} -eq 0 ]; then
    v_datetime=`date "+%Y%m%d%H%M%S"`
    v_file="${v_dir}/${ENV_ZAIF_API_CURRENCIES_FILE}.${v_sno}.${v_datetime}"
    wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_CURRENCIES}"
    if [ $? -ne 0 ]; then
        echo "${v_file} get failed."
    fi
    sleep 5s
fi
fi

# currency_pairs 通貨ペア情報 /currency_pairs/{currency_pair}
if [ -n "${ENV_ZAIF_API_CURRENCYPAIRS_FLG}" ]; then
v_err=0
v_dir="${ENV_ZAIF_API_CURRENCYPAIRS_DIR}"

if [ -d "${v_dir}" ]; then
    v_err=0

elif [ -e "${v_dir}" ]; then
    echo "${v_dir} is exist, and not a directory."
    v_err=1

else
    mkdir -p "${v_dir}"
    if [ $? -ne 0 ]; then
        echo "${v_dir} create failed."
        v_err=1
    fi
fi

if [ ${v_err} -eq 0 ]; then
    v_datetime=`date "+%Y%m%d%H%M%S"`
    v_file="${v_dir}/${ENV_ZAIF_API_CURRENCYPAIRS_FILE}.${v_sno}.${v_datetime}"
    wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_CURRENCYPAIRS}"
    if [ $? -ne 0 ]; then
        echo "${v_file} get failed."
    fi
    sleep 5s
fi
fi

# last_price 現在の終値 /last_price/{currency_pair}
if [ -n "${ENV_ZAIF_API_LASTPRICE_FLG}" ]; then
v_err=0
v_dir="${ENV_ZAIF_API_LASTPRICE_DIR}"
if [ -d "${v_dir}" ]; then
    v_err=0

elif [ -e "${v_dir}" ]; then
    echo "${v_dir} is exist, and not a directory."
    v_err=1

else
    mkdir -p "${v_dir}"
    if [ $? -ne 0 ]; then
        echo "${v_dir} create failed."
        v_err=1
    fi
fi

if [ ${v_err} -eq 0 ]; then

    # Main
    for v_pair1 in ${CF_ZAIF_API_MAIN_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_MAIN_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_LASTPRICE_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_LASTPRICE}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

    # Token
    for v_pair1 in ${CF_ZAIF_API_TOKEN_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_TOKEN_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_LASTPRICE_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_LASTPRICE}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

    # COMSA
    for v_pair1 in ${CF_ZAIF_API_COMSA_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_COMSA_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_LASTPRICE_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_LASTPRICE}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done
fi
fi

# ticker ティッカー /ticker/{currency_pair}
if [ -n "${ENV_ZAIF_API_TICKER_FLG}" ]; then
v_err=0
v_dir="${ENV_ZAIF_API_TICKER_DIR}"
if [ -d "${v_dir}" ]; then
    v_err=0

elif [ -e "${v_dir}" ]; then
    echo "${v_dir} is exist, and not a directory."
    v_err=1

else
    mkdir -p "${v_dir}"
    if [ $? -ne 0 ]; then
        echo "${v_dir} create failed."
        v_err=1
    fi
fi

if [ ${v_err} -eq 0 ]; then

    # Main
    for v_pair1 in ${CF_ZAIF_API_MAIN_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_MAIN_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_TICKER_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_TICKER}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

    # Token
    for v_pair1 in ${CF_ZAIF_API_TOKEN_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_TOKEN_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_TICKER_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_TICKER}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

    # COMSA
    for v_pair1 in ${CF_ZAIF_API_COMSA_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_COMSA_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_TICKER_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_TICKER}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done
fi
fi

# trades 全ての取引履歴 /trades/{currency_pair}
if [ -n "${ENV_ZAIF_API_TRADES_FLG}" ]; then
v_err=0
v_dir="${ENV_ZAIF_API_TRADES_DIR}"
if [ -d "${v_dir}" ]; then
    v_err=0

elif [ -e "${v_dir}" ]; then
    echo "${v_dir} is exist, and not a directory."
    v_err=1

else
    mkdir -p "${v_dir}"
    if [ $? -ne 0 ]; then
        echo "${v_dir} create failed."
        v_err=1
    fi
fi

if [ ${v_err} -eq 0 ]; then

    # Main
    for v_pair1 in ${CF_ZAIF_API_MAIN_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_MAIN_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_TRADES_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_TRADES}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

    # Token
    for v_pair1 in ${CF_ZAIF_API_TOKEN_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_TOKEN_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_TRADES_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_TRADES}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

    # COMSA
    for v_pair1 in ${CF_ZAIF_API_COMSA_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_COMSA_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_TRADES_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_TRADES}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done
fi
fi

# depth 板情報 /depth/{currency_pair}
if [ -n "${ENV_ZAIF_API_DEPTH_FLG}" ]; then
v_err=0
v_dir="${ENV_ZAIF_API_DEPTH_DIR}"
if [ -d "${v_dir}" ]; then
    v_err=0

elif [ -e "${v_dir}" ]; then
    echo "${v_dir} is exist, and not a directory."
    v_err=1

else
    mkdir -p "${v_dir}"
    if [ $? -ne 0 ]; then
        echo "${v_dir} create failed."
        v_err=1
    fi
fi

if [ ${v_err} -eq 0 ]; then

    # Main
    for v_pair1 in ${CF_ZAIF_API_MAIN_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_MAIN_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_DEPTH_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_DEPTH}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

    # Token
    for v_pair1 in ${CF_ZAIF_API_TOKEN_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_TOKEN_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_DEPTH_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_DEPTH}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

    # COMSA
    for v_pair1 in ${CF_ZAIF_API_COMSA_PAIR1}
    do
        for v_pair2 in ${CF_ZAIF_API_COMSA_PAIR2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_ZAIF_API_DEPTH_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_ZAIF_API_DEPTH}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done
fi
fi

