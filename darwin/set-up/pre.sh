# install rudix and additional tools
if ! command -v rudix >/dev/null 2>&1; then
    curl -s https://raw.github.com/rudix-mac/package-manager/master/rudix.py | sudo python - install rudix
fi
    
install_pkg tmux

# install textmate set-up bundle
if [ ! -d $HOME/Library/Application\ Support/Avian/Bundles ]; then
    mkdir -p $HOME/Library/Application\ Support/Avian/Bundles
fi

ln -snf $SRC/darwin/set-up/avian/set-up.tmbundle $HOME/Library/Application\ Support/Avian/Bundles/
