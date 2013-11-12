#!/usr/bin/env bash

source $SRC/libs/config.lib.sh

# initialization
PHP_DIR=${PHP_DIR:-/opt}    # path to installed php versions
PHP_CUR=$(which php)        # current installed php version

if [ -e $PHP_DIR/php -a \! -h $PHP_DIR/php ]; then
    echo "$PHP_DIR/php exists but is no symlink!"
    exit 1
fi

# collect a list of installed 
declare -a PHP_INST
idx=0

for i in $(find $PHP_DIR -name "php-*" -prune \( -type d -and ! -type l \)`; do
    PHP_INST[$idx]=$i

    idx=$((idx + 1))
done

if [[ $idx == 0 ]]; then
    echo "no php version to switch to"
    exit
fi

# build menu
PHP_PWD=$(cd $PHP_DIR/php/bin/ 2>/dev/null && pwd -P)

if [ "$PHP_PWD" != "" ]; then
    echo "current: $PHP_PWD"
    echo ""
fi

PHP_CNT=${#PHP_INST[@]}
for ((i=0; i < $PHP_CNT; i++)); do
    echo "[$((i + 1))] ${PHP_INST[$i]}"
done

echo ""
echo "[0] exit"

while true; do
    read -p "switch to? " -n1 PHP_TO
    echo ""

    if ! [[ "$PHP_TO" =~ ^[0-9]+$ ]]; then
        continue;
    elif [[ $PHP_TO == 0 ]]; then
        exit
    elif [[ $PHP_TO -ge 1 && $PHP_TO -le $PHP_CNT ]]; then
        break;
    fi
done

# switch php
ln -snf ${PHP_INST[$((PHP_TO - 1))]} $PHP_DIR/php

echo "now using $(cd $PHP_DIR/php/bin/ 2>/dev/null && pwd -P)"
