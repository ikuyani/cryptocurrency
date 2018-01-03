#!/bin/bash

######################################################################
# coincheck_getpublicdata.sh
#
# [Description]
#  CoincheckのPublic APIのデータを取得する。
#  実行にはwgetが必要。
#
# [Arguments]
#  * $1: 設定ファイルパス(必須)
#        設定ファイルはcoincheck.settings.sampleを参照
#  * $2: 出力ファイルのシリアルナンバー
#
# [Example]
#  ./coincheck_getpublicdata.sh ./coincheck.settings.sample
#
######################################################################

if [ -z "${1}" -o ! -f "${1}" ]; then
    echo "Settings[${1}] is invalid."
    exit 1
fi

source "${1}"

if [ ! -f "${ENV_COINCHECK_CONFIG}" ]; then
    echo "Config[${ENV_COINCHECK_CONFIG}] is invalid."
    exit 1
fi

source "${ENV_COINCHECK_CONFIG}"

v_sno=${2}
if [ -z "${v_sno}" ]; then
    v_sno=`date "+%Y%m%d%H"`
fi

# Ticker ティッカー /api/ticker
if [ -n "${ENV_COINCHECK_API_TICKER_FLG}" ]; then
v_err=0
v_dir="${ENV_COINCHECK_API_TICKER_DIR}"

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
    v_file="${v_dir}/${ENV_COINCHECK_API_TICKER_FILE}.${v_sno}.${v_datetime}"
    wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_COINCHECK_API_TICKER}"
    if [ $? -ne 0 ]; then
        echo "${v_file} get failed."
    fi
    sleep 5s
fi
fi

# Public trades 全取引履歴 /api/trades
if [ -n "${ENV_COINCHECK_API_TRADES_FLG}" ]; then
v_err=0
v_dir="${ENV_COINCHECK_API_TRADES_DIR}"
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

    for v_pair1 in ${CF_COINCHECK_API_TRADES_P_PAIR_V1}
    do
        for v_pair2 in ${CF_COINCHECK_API_TRADES_P_PAIR_V2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_COINCHECK_API_TRADES_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_COINCHECK_API_TRADES}?${CF_COINCHECK_API_TRADES_P_PAIR_N}=${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

fi
fi

# Order Book 板情報 /api/order_books
if [ -n "${ENV_COINCHECK_API_ORDERBOOKS_FLG}" ]; then
v_err=0
v_dir="${ENV_COINCHECK_API_ORDERBOOKS_DIR}"

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
    v_file="${v_dir}/${ENV_COINCHECK_API_ORDERBOOKS_FILE}.${v_sno}.${v_datetime}"
    wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_COINCHECK_API_ORDERBOOK}"
    if [ $? -ne 0 ]; then
        echo "${v_file} get failed."
    fi
    sleep 5s
fi
fi

# Calc Rate レート取得 /api/exchange/orders/rate
if [ -n "${ENV_COINCHECK_API_ORDERSRATE_FLG}" ]; then
v_err=0
v_dir="${ENV_COINCHECK_API_ORDERSRATE_DIR}"
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

    for v_type in ${CF_COINCHECK_API_ORDERSRATE_P_TYPE_V}
    do
        for v_pair1 in ${CF_COINCHECK_API_ORDERSRATE_P_PAIR_V1}
        do
            for v_pair2 in ${CF_COINCHECK_API_ORDERSRATE_P_PAIR_V2}
            do
                v_type_query="${CF_COINCHECK_API_ORDERSRATE_P_TYPE_N}=${v_type}"
                v_pair_query="${CF_COINCHECK_API_ORDERSRATE_P_PAIR_N}=${v_pair1}_${v_pair2}"

                v_datetime=`date "+%Y%m%d%H%M%S"`
                v_file="${v_dir}/${ENV_COINCHECK_API_ORDERSRATE_FILE}.amount${CF_COINCHECK_API_ORDERSRATE_P_AMOUNT_V}.${v_type}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
                v_amount_query="${CF_COINCHECK_API_ORDERSRATE_P_AMOUNT_N}=${CF_COINCHECK_API_ORDERSRATE_P_AMOUNT_V}"
                wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_COINCHECK_API_ORDERSRATE}?${v_type_query}&${v_pair_query}&${v_amount_query}"
                if [ $? -ne 0 ]; then
                    echo "${v_file} get failed."
                fi
                sleep 5s

#                v_datetime=`date "+%Y%m%d%H%M%S"`
#                v_file="${v_dir}/${ENV_COINCHECK_API_ORDERSRATE_FILE}.price${CF_COINCHECK_API_ORDERSRATE_P_PRICE_V}.${v_type}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
#                v_price_query="${CF_COINCHECK_API_ORDERSRATE_P_PRICE_N}=${CF_COINCHECK_API_ORDERSRATE_P_PRICE_V}"
#                wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_COINCHECK_API_ORDERSRATE}?${v_type_query}&${v_pair_query}&${v_price_query}"
#                if [ $? -ne 0 ]; then
#                    echo "${v_file} get failed."
#                fi
#                sleep 5s
            done
        done
    done

fi
fi

# Buy Rate 販売レート取得 /api/rate/[pair]
if [ -n "${ENV_COINCHECK_API_RATE_FLG}" ]; then
v_err=0
v_dir="${ENV_COINCHECK_API_RATE_DIR}"
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
    v_file="${v_dir}/${ENV_COINCHECK_API_RATE_FILE}.${CF_COINCHECK_API_RATE_PAIR_ALL}.${v_sno}.${v_datetime}"
    wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_COINCHECK_API_RATE}/${CF_COINCHECK_API_RATE_PAIR_ALL}"
    if [ $? -ne 0 ]; then
        echo "${v_file} get failed."
    fi

    for v_pair1 in ${CF_COINCHECK_API_RATE_PAIR_1}
    do
        for v_pair2 in ${CF_COINCHECK_API_RATE_PAIR_2}
        do
            v_datetime=`date "+%Y%m%d%H%M%S"`
            v_file="${v_dir}/${ENV_COINCHECK_API_RATE_FILE}.${v_pair1}_${v_pair2}.${v_sno}.${v_datetime}"
            wget ${CF_WGET_OPTION} -O "${v_file}" "${CF_COINCHECK_API_RATE}/${v_pair1}_${v_pair2}"
            if [ $? -ne 0 ]; then
                echo "${v_file} get failed."
            fi
            sleep 5s
        done
    done

fi
fi

