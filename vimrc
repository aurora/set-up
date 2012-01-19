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

" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround    

" auto indent after {
set autoindent
set smartindent

" show line numbers relative to cursor position
set relativenumber

" keep cursor 8 lines from top/bottom when page starts to scroll
set scrolloff=8

" show invisible characters TextMate style
set listchars=tab:▸\ ,eol:¬
set list

" set the search scan to wrap around the file
set wrapscan

" case insensitive searches / intelligent case sensitive searches
set ignorecase
set smartcase

" highlight all search matches
set hlsearch

" show line and column information
"set ruler

" show matching brackets
set showmatch

" make command line two lines high
set ch=2

" set visual bell
set vb

" set color scheme and enable syntax highlighting
" get it from: https://github.com/altercation/vim-colors-solarized
if &t_Co > 2 || has("gui_running")
    syntax on
endif

if &t_Co >= 256 || has("gui_running")
    if has("gui_running")
        set background=light
    else
        let g:solarized_termcolors=16
        let g:solarized_termtrans=1
        set background=dark
    endif

    silent! colorscheme solarized
endif

set guifont=Menlo:h14.00

" enable filetype plugin, also required for snipmate plugin
filetype plugin on

" change leader key
let mapleader = ","

" fix vim regex handling
nnoremap / /\v
vnoremap / /\v

" improve line wrapping behaviour
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" deactive help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" autosave, when vim window is losing focus
au FocusLost * :wa

" apply 'sudo' trick, allow saving a file if you forgot 
" sudo when editing a file you need higher privileges
cmap w!! w !sudo tee % >/dev/null

" always show tab-bar in gui
if has("gui_running")
    set showtabline=2
endif

" custom status line
set laststatus=2                                " make permanent
set statusline=                                 " clear the statusline
set statusline+=%f\                             " file name
set statusline+=%h%m%r%w                        " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},     " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},    " encoding
set statusline+=%{&fileformat}]                 " file format
set statusline+=%-14.(%l,%c%V%)\ %<%P           " offset

