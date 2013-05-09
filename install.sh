SRC=$HOME/dotfiles

# install erlang related stuff
ERLC=$(which erlc)

if [ "$ERLC" != "" ]; then
    $ERLC -o $SRC/erl/ $SRC/erl/aur.erl 
    ln -snf $SRC/erlang $HOME/.erlang
fi

# install stuff from etc folder
# -- vim releated stuff
ln -snf $SRC/etc/vimrc $HOME/.vimrc
ln -snf $SRC/etc/vim $HOME/.vim

# -- sublime text related stuff only if sublime text is installed
if [ -d $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages ]; then
	[ -d $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages/User ] || mkdir $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages/User
	
	find $SRC/etc/sublime/* -type f -exec ln -snf "{}" $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/ \;
fi

# install binaries
if [ ! -d $HOME/bin ]; then
    mkdir $HOME/bin
fi

ls -1 $SRC/bin | while read cmd; do
    ln -snf $SRC/bin/$cmd $HOME/bin/$cmd
done

