inoremap jk <Esc>
inoremap kj <Esc>
let mapleader = "\<Space>"
runtime macros/matchit.vim
syntax enable
set background=light
colorscheme solarized
let g:airline_theme='solarized'
set nu

" adapt to german keyboard
map ü <C-]>
map ö [
map ä ]
map Ö {
map Ä }
map ß /

set noswapfile
set clipboard=unnamedplus


filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

packadd minpac
call minpac#init()

call minpac#add('altercation/vim-colors-solarized')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('mileszs/ack.vim')
call minpac#add('pangloss/vim-javascript')
call minpac#add('mxw/vim-jsx')
call minpac#add('w0rp/ale')
call minpac#add('tpope/vim-fugitive')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('mustache/vim-mustache-handlebars')
call minpac#add('mattn/emmet-vim')

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0


" check one time after 4s of inactivity in normal mode
set autoread
au CursorHold * checktime

let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled = 1

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
let g:user_emmet_leader_key='<C-Z>'

