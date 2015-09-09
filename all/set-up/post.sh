source $HOME/set-up/libs/config.lib.sh

# install erlang related stuff only if erlang is available on the system
if command -v erlc >/dev/null 2>&1; then
    erlc -o $SRC/all/set-up/erl/ $SRC/all/set-up/erl/aur.erl 
    ln -snf $SRC/all/set-up/.erlang $HOME/.erlang
fi

# add ~/bin to path
(
    PATH=""
    
    source $HOME/.bash_profile
    
    if ! [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
        echo "" >> $HOME/.bash_profile
        echo "export PATH=\$HOME/bin:\$PATH" >> $HOME/.bash_profile
    fi
)

# configure loading of bash_set-up.rc
grep "bash_set-up.rc" $HOME/.bash_profile 1>/dev/null 2>/dev/null

if [ $? -ne 0 ]; then
    echo "" >> $HOME/.bash_profile
    echo "source \$HOME/etc/bash_set-up.rc" >> $HOME/.bash_profile
fi
