#
# install.sh
#
# copyright (c) 2013 by Harald Lapp <harald@octris.org>
#

SRC=$HOME/set-up

# helper function for package installation
function install_pkg {
    local NAME=$1
    
    [[ $2 ]] && local TEST=$2 || local TEST=$1
    
    local OS=$(uname)
    
    if ! command -v $TEST >/dev/null 2>&1; then
        if [ "$MESG" != "" ]; then
            echo "installing '$NAME'"
        fi
    
        if [ "$OS" = "Darwin" ]; then
            sudo rudix install $NAME
        elif [ "$OS" = "Linux" ]; then
            sudo apt-get install $NAME
        fi
    fi
}

# install binaries
if [ ! -d $HOME/bin ]; then
    mkdir $HOME/bin
fi

find $SRC/bin/* -type f -exec ln -snf "{}" $HOME/bin/ \;

# OS specific stuff
OS=$(uname)

if [ "$OS" = "Darwin" ]; then
    # install tools from sub-modules
    ln -snf $SRC/rmate/rmate $HOME/bin/
    ln -snf $SRC/iterm2-zmodem/iterm2-zmodem $HOME/bin/
    
    # install rudix
    if ! command -v rudix >/dev/null 2>&1; then
        curl -s https://raw.github.com/rudix-mac/package-manager/master/rudix.py | sudo python - install rudix
    fi
        
    # install additional tools
    install_pkg tmux
elif [ "$OS" = "Linux" ]; then
    # install additional tools
    install_pkg tmux
    install_pkg lrzsz rz
fi

# install erlang related stuff only if erlang is available on the system
if command -v erlc >/dev/null 2>&1; then
    erlc -o $SRC/erl/ $SRC/erl/aur.erl 
    ln -snf $SRC/erlang $HOME/.erlang
fi

# install stuff from etc folder
# -- tmux releated stuff
ln -snf $SRC/etc/tmux.conf $HOME/.tmux.conf

# -- vim releated stuff
ln -snf $SRC/etc/vimrc $HOME/.vimrc
ln -snf $SRC/etc/vim $HOME/.vim
