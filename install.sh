#
# install.sh
#
# copyright (c) 2013 by Harald Lapp <harald@octris.org>
#

SRC=$HOME/set-up
OS=$(uname | tr '[:upper:]' '[:lower:]')

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
    
    if ! command -v $TEST >/dev/null 2>&1; then
        if [ "$MESG" != "" ]; then
            echo "installing '$NAME'"
        fi
    
        if [ "$OS" = "darwin" ]; then
            sudo rudix install $NAME
        elif [ "$OS" = "linux" ]; then
            sudo apt-get install $NAME
        fi
    fi
}

# install targets
for TARGET in all $OS; do
    if [ -f $SRC/$TARGET/set-up/pre.sh ]; then
        . $SRC/$TARGET/set-up/pre.sh
    fi

    find $SRC/$TARGET ! -name $(basename $TARGET) -prune -type f -exec ln -snf {} $HOME/ \;
    
    for i in $(find $SRC/$TARGET/* -prune -type d ! -name "set-up" ); do
        NAME=$(basename $i)
        
        if [ ! -d $HOME/$NAME ]; then
            mkdir $HOME/$NAME
        fi
        
        find $i/* -prune -exec ln -snf {} $HOME/$NAME/ \;
    done

    if [ -f $SRC/$TARGET/set-up/post.sh ]; then
        . $SRC/$TARGET/set-up/post.sh
    fi
done

