#
# install.sh
#
# copyright (c) 2013 by Harald Lapp <harald@octris.org>
#

SRC=$HOME/set-up

# set-up needs to be downloaded first
if [ ! -d $SRC ]; then
    while true; do
        read -p "'$SRC' not found, download from github? (y/n) " yn

        case $yn in
            [Yy]) 
                break;;
            [Nn])
                exit;;
        esac
    done
    
    TRY=0
    while true; do
        TMP="/tmp/set-up-$$-$RANDOM"
        TRY=$((TRY + 1))
        
        if [ ! -d $TMP ]; then
            mkdir $TMP    
            break;
        elif [ $TRY -eq 3 ]; then
            echo "unable to create temporary directory after '$TRY' tries"
            exit
        fi
    done
    
    function download {
        local URL=$1
        local DST=$2
        local SRC

        curl -L -s $URL | tar -C $TMP -xz

        if [ $(ls -1 $TMP/ | wc -l) -ne 1 ]; then
            echo "unable to determine download directory"
            exit
        fi
        
        SRC="$TMP/$(ls -1 $TMP)"
        
        if [ -d "$DST" ]; then
            rmdir "$DST"
            
            if [ $? -ne 0 ]; then
                echo "error moving '$SRC' to '$DST'"
                exit
            fi
        fi
        
        mv "$SRC" "$DST"
    }
    
    download https://github.com/aurora/set-up/tarball/master $SRC
    download https://github.com/aurora/rmate/tarball/master $SRC/rmate/
    download https://github.com/aurora/iterm2-zmodem/tarball/master $SRC/iterm2-zmodem/
    
    rmdir $TMP
fi

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
