# set-up

## Preface

Provides an installer for setting-up my working environment with useful tools and 
needed configuration files.

## Installation

### Using git

Clone repository into home-directory:

    git clone --recursive https://github.com/aurora/set-up.git
    
Execute installer script:

    cd ~/set-up
    ./install.sh

### When git is not available

Run the following command in a shell (bash):

    (exec 3<&1; bash <&3 <(curl -s https://raw.github.com/aurora/set-up/master/install.sh))

## Installed tools

The following tools and packages will be installed, depending on the operating system used:

### Mac OS X

* iterm2-zmodem
* rmate
* rudix
* tmux

### Linux (Ubuntu)

* rmate
* tmux
