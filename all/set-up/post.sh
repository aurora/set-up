source $HOME/set-up/libs/config.lib.sh

# install erlang related stuff only if erlang is available on the system
if command -v erlc >/dev/null 2>&1; then
    erlc -o $SRC/all/set-up/erl/ $SRC/all/set-up/erl/aur.erl 
    ln -snf $SRC/all/set-up/.erlang $HOME/.erlang
fi

# install php switcher only if php is present
PHP_DIR=${PHP_DIR:-/opt}            # path to installed php versions
PHP_CNT=$(find /opt -name "php-*" -prune \( -type d -and ! -type l \) | wc -l)

if [ "$PHP_CNT" != "0" ]; then
    ln -snf $SRC/all/set-up/bin/switch-php.sh $HOME/bin/
fi
