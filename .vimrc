" ~/.vimrc
" ~/.vim
" ~/.vim/autoload
" ~/.vim/autoload/plug.vim
" ~/.vim/plugged

" mkdir -p ~/.vim/autoload ~/.vim/plugged
" To install vim-plug vim plugin manager, in the autoload directory
" wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then run :PlugInstall in vim

:autocmd BufEnter * let g:gitbranch=system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")


" default the statusline to green when entering Vim

highlight InsertMode ctermbg=022
highlight VisualMode ctermbg=005
highlight NormalMode ctermbg=055
highlight color1 ctermbg=088
highlight color2 ctermbg=247
highlight color2 ctermbg=244

" Formats the statusline
set laststatus=2
set statusline=
set statusline+=%#NormalMode#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#InsertMode#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#VisualMode#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#color1#
set statusline+=\ %{g:gitbranch}\ 
set statusline+=%#color2#
set statusline+=\ %f                           " file name
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

set statusline+=\ %#color3#
set statusline+=\ %=
set statusline+=%y      "filetype
set statusline+=\                  " current column
set statusline+=%l:%c\ %p%%            " line X of Y [percent of file]

runtime! debian.vim


" Removes trailing spaces when saving
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
:autocmd BufWritePre *java,*.c,*h,*py,*rb,*sh,*.v :call <SID>StripTrailingWhitespaces()
" :autocmd BufWritePost .vimrc source %

" Useful when git changes the file, reloads the file
" when it was modified from outside vim
set autoread

" Indentation
filetype plugin indent on
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

" Selection of word under cursor
:nnoremap <C-X> viw

:nnoremap <C-J> :tabp<CR>
:nnoremap <C-K> :tabn<CR>

set tabstop=4 " length of tab press
set softtabstop=4 " length of tab suppr
set shiftwidth=4 " when indenting with >
set smarttab
set expandtab " change tabulations en espaces
" Apparence
set background=dark
set guifont=Menlo\ 14

" Status line
" Abbreviations
iabbrev adn and
" iabbrev #inc #include<>
iabbrev #! #!/bin/bash
iabbrev direcotry directory
iabbrev Sys System.out.println();

" autocmd VimEnter * echo "ZA WARUDO !"


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


