SRC=$HOME/dotfiles

# install erlang related stuff
ERLC=$(which erlc)

if [ "$ERLC" != "" ]; then
    $ERLC -o $SRC/erl/ $SRC/erl/user_default.erl 
fi

ln -snf $SRC/erlang $HOME/.erlang

# install stuff from etc folder
ln -snf $SRC/etc/vimrc $HOME/.vimrc
ln -snf $SRC/etc/vim $HOME/.vim
