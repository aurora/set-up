# install rudix and additional tools
if ! command -v rudix >/dev/null 2>&1; then
    curl -s https://raw.github.com/rudix-mac/package-manager/master/rudix.py | sudo python - install rudix
fi
    
install_pkg tmux
