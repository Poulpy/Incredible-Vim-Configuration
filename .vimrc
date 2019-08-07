call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'valloric/youcompleteme'
Plug 'ollykel/v-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()
syntax on

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

:autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" Useful when git changes the file
set autoread
autocmd vimenter * NERDTree

"filetype plugin indent on
set mouse=a
set number
:autocmd Filetype ruby set softtabstop=2
:autocmd Filetype ruby set sw=2
:autocmd Filetype ruby set ts=2

set background=dark
set guifont=Menlo\ 14
