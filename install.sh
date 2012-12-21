SRC=$HOME/dotfiles

# install erlang related stuff
ERLC=$(which erlc)

if [ "$ERLC" != "" ]; then
    $ERLC -o $SRC/erl/ $SRC/erl/aur.erl 
    ln -snf $SRC/erlang $HOME/.erlang
fi

# install stuff from etc folder
ln -snf $SRC/etc/vimrc $HOME/.vimrc
ln -snf $SRC/etc/vim $HOME/.vim

# install binaries
if [ ! -d $HOME/bin ]; then
    mkdir $HOME/bin
fi

ls -1 $SRC/bin | while read cmd; do
    ln -snf $SRC/bin/$cmd $HOME/bin/$cmd
done

