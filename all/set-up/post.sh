source $HOME/set-up/libs/config.lib.sh

# install erlang related stuff only if erlang is available on the system
if command -v erlc >/dev/null 2>&1; then
    erlc -o $SRC/all/set-up/erl/ $SRC/all/set-up/erl/aur.erl 
    ln -snf $SRC/all/set-up/.erlang $HOME/.erlang
fi
