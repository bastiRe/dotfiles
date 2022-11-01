set relativenumber
set number
set mouse=a
set clipboard+=unnamedplus
set virtualedit=all
set scrollback=100000 
set termguicolors 
set laststatus=0
set background=dark
set ignorecase
set scrolloff=8

map <silent> q :qa!<CR>

" function! KittyBufferHistoryClean()
"   set modifiable
"   set noconfirm
"   " clean ascii/ansi code  (starts with ^[)
"   silent! %s/\e\[[0-9:;]*m//g
"   silent! %s/[^[:alnum:][:punct:][:space:]]//g
"   silent! %s/\e\[[^\s]*\s//g
"   " remove empty spaces from end
"   silent! %s/\s*$//
"   let @/ = ""
"   set rnu
"   " map q to force quit
"   cnoremap q q!
" endfunction
" command! KittyBufferHistoryClean call KittyBufferHistoryClean()

" Short highlight on yanked text
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup start_at_bottom
    autocmd!
    autocmd VimEnter * normal G
augroup END

augroup prevent_insert
    autocmd!
    autocmd TermEnter * stopinsert
augroup END
