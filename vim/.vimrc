filetype plugin indent on

set hidden

set list
set listchars=tab:›\ ,nbsp:␣,trail:•,precedes:«,extends:»

set lazyredraw

set wildignorecase
set wildmenu
set wildoptions=pum

set hlsearch
set incsearch
set ignorecase
set smartcase

set background=dark

" Status line
set laststatus=2
set statusline=
set statusline+=[%n]
set statusline+=\ %<%f
set statusline+=\ %h%w%m
set statusline+=%=
set statusline+=%y
set statusline+=\ %l:%c
set statusline+=\ %P

" Key bindings
let mapleader="\<Space>"
let maplocalleader="\<Bslash>"

nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>m :make<CR>
