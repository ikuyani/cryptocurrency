#!/bin/bash

v_log=./package.test.log
echo  > ${v_log}

./start.sh.test ${v_log}
./stop.sh.test ${v_log}

