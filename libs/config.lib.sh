# load configuration file if present
if [ -f $HOME/etc/set-up.conf ]; then
    source $HOME/etc/set-up.conf
fi

# determine operating system
OS=$(uname | tr '[:upper:]' '[:lower:]')

