" Configuration file for vim
"

" CVE-2007-2438
set modelines=0

" use vim defaults instead of 100% vi compatibility
set nocompatible

" more powerful backspacing
set backspace=2

" do not write backup files
set nobackup
set nowritebackup

" do not write swap files
set noswapfile

" tab stops and tab to space expanding
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" auto indent after {
set autoindent
set smartindent

" show line numbers
set number

" keep cursor 8 lines from top/bottom when page starts to scroll
set scrolloff=8

" show invisible characters
set listchars=tab:>-,trail:-
set list

" set the search scan to wrap around the file
set wrapscan

" case insensitive searches
set ignorecase

" highlight all search matches
set hlsearch

" show line and column information
set ruler

" show matching brackets
set showmatch

" make command line two lines high
set ch=2

" set visual bell
set vb

" set color scheme and enable syntax highlighting
" get it from: https://github.com/altercation/vim-colors-solarized
syntax on
set background=light
colorscheme solarized

" set font and size
set guifont=Bitstream\ Vera\ Sans\ Mono:h14

" enable filetype plugin, also required for snipmate plugin
filetype plugin on

" always show tabbar
set showtabline=2
