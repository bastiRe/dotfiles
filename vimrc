inoremap jk <Esc>
let mapleader = "\<Space>"
runtime macros/matchit.vim

"General config
let g:airline_theme='solarized'
set background=light
set nu
set relativenumber
set ruler
set nocompatible
set nobackup
set nowritebackup
set hidden
set lazyredraw
set history=100
set scrolloff=4
set incsearch
set autowrite

" adapt to german keyboard
map ü <C-]>
map ö [
map ä ]
map Ö {
map Ä }
map ß /

" better handling of wrapped lines
nmap j gj
nmap k gk

"LEADER commands

" Split edit vim rc
nmap <leader>vr :sp $MYVIMRC<cr>
" Source vimrc
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>v :vnew <C-r>=escape(expand("%:p:h"), ' ') . '/'<cr>
nmap <leader>h :new <C-r>=escape(expand("%:p:h"), ' ') . '/'<cr>


set noswapfile
set clipboard+=unnamed


filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

" Install vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Packages
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ruanyl/vim-fixmyjs'
Plug 'leafgarland/typescript-vim'
Plug 'scrooloose/nerdtree'

call plug#end()

" Solarized settings
syntax enable
set background=light
colorscheme solarized

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

"configure fixmyjs
let g:fixmyjs_engine = 'eslint'
let g:fixmyjs_rc_filename = ['.eslintrc', '.eslintrc.json']
" use linting tool installed locally in node_modules folder
let g:fixmyjs_use_local = 1

noremap <Leader>f :Fixmyjs<CR>
map <C-n> :NERDTreeToggle<CR>


