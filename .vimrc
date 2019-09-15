" ~/.vimrc
" ~/.vim
" ~/.vim/autoload
" ~/.vim/autoload/plug.vim
" ~/.vim/plugged

" mkdir -p ~/.vim/autoload ~/.vim/plugged
" To install vim-plug vim plugin manager, in the autoload directory
" wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then run :PlugInstall in vim

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter' " gutter for git
Plug 'ollykel/v-vim' " V color syntax
Plug 'vim-airline/vim-airline' " AWESOME status bar
Plug 'ctrlpvim/ctrlp.vim' " file finder

call plug#end()

runtime! debian.vim

" Removes trailing spaces when saving
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
:autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Useful when git changes the file, reloads the file
" when it was modified from outside vim
set autoread

" Indentation
"filetype plugin indent on
syntax on " Syntax highlighting
set number
set mouse=a
set showmatch " Show matching brackets.
set smartcase " Do smart case matching
set list " display invisible characters
set wildmenu " autocomplete in command mode
set visualbell " to avoid annoying bell noise
set lazyredraw " for macros, better performance
:autocmd Filetype ruby set softtabstop=2
:autocmd Filetype ruby set sw=2
:autocmd Filetype ruby set ts=2

" Shows dots whenever there are trailing spaces
:set list listchars=tab:»·,trail:·
:highlight LineNr term=bold ctermfg=darkgray guifg=darkgray
:highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%80v.*/
" Source a global configuration file if available
:nnoremap <F8> :setl noai nocin nosi inde=<CR>

set tabstop=4 " length of tab press
set softtabstop=4 " length of tab suppr
set shiftwidth=4 " when indenting with >
set smarttab
set expandtab " change tabulations en espaces
" Apparence
set background=dark
set guifont=Menlo\ 14

set statusline=\ >\ %-4F\ >\ %-4y\ %l/%L

" Abbreviations
iabbrev adn and
" iabbrev #inc #include<>
iabbrev #! #!/bin/bash
iabbrev direcotry directory
iabbrev Sys System.out.println();

autocmd VimEnter * echo "ZA WARUDO!"


" :Git
command! -complete=file -nargs=* Git call s:RunShellCommand('git '.<q-args>)

" :Shell
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
    echo a:cmdline
    let expanded_cmdline = a:cmdline
    for part in split(a:cmdline, ' ')
        if part[0] =~ '\v[%#<]'
            let expanded_part = fnameescape(expand(part))
            let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
        endif
    endfor
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'You entered:    ' . a:cmdline)
    call setline(2, 'Expanded Form:  ' .expanded_cmdline)
    call setline(3,substitute(getline(2),'.','=','g'))
    execute '$read !'. expanded_cmdline
    setlocal nomodifiable
    1
endfunction


