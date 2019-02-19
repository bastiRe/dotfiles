inoremap jk <Esc>
let mapleader = "\<Space>"
runtime macros/matchit.vim

" Python settings vor NVIM
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:gruvbox_italic=1

" Line Numbers
set nu
set relativenumber

" General Settings
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
set noswapfile
set clipboard=unnamed
filetype plugin on
filetype plugin indent on
set showcmd " show incomplete commands

" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" better handling of wrapped lines
nmap j gj
nmap k gk

" LEADER commands

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
" Split edit vim rc
nmap <leader>vr :sp $MYVIMRC<cr>
" Source vimrc
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>v :vnew <C-r>=escape(expand("%:p:h"), ' ') . '/'<cr>
nmap <leader>h :new <C-r>=escape(expand("%:p:h"), ' ') . '/'<cr>

" autocheck file for updates after 4s of inactivity in normal mode
set autoread
au CursorHold,CursorHoldI * checktime

" Install vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Packages
call plug#begin('~/.vim/plugged')
  " Theme-Packages
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'morhetz/gruvbox'
  " Navigating/Text Plugins
  Plug 'scrooloose/nerdtree'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'mileszs/ack.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'mattn/emmet-vim'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'wincent/terminus'
  Plug 'tpope/vim-fugitive'
  Plug 'ElmCast/elm-vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  " Syntax Highlighting PACKAGES
  " ALE {{{
    Plug 'w0rp/ale' " Asynchonous linting engine
    let g:ale_set_highlights = 0
    let g:ale_change_sign_column_color = 0
    let g:ale_sign_column_always = 1
    let g:ale_sign_error = '✖'
    let g:ale_sign_warning = '⚠'
    let g:ale_echo_msg_error_str = '✖'
    let g:ale_echo_msg_warning_str = '⚠'
    let g:ale_echo_msg_format = '%severity% %s% [%linter%% code%]'
    " let g:ale_completion_enabled = 1

    let g:ale_linters = {
        \   'javascript': ['eslint'],
        \   'typescript': ['tsserver', 'tslint'],
        \   'typescript.tsx': ['tsserver', 'tslint'],
        \   'html': []
        \}
    let g:ale_fixers = {}
    let g:ale_fixers['javascript'] = ['prettier']
    let g:ale_fixers['typescript'] = ['prettier', 'tslint']
    let g:ale_fixers['json'] = ['prettier']
    let g:ale_fixers['css'] = ['prettier']
    let g:ale_javascript_prettier_use_local_config = 1
    let g:ale_fix_on_save = 0
    nmap <silent><leader>af :ALEFix<cr>
  " }}}

  " Completion {{{
    if (has('nvim'))
      Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
      Plug 'Shougo/deoplete.nvim'
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
    endif
    let g:deoplete#enable_at_startup = 1
  " }}}
  "
  " Language-Specific Configuration {{{
  " html / templates {{{
      " emmet support for vim - easily create markdup wth CSS-like syntax
      Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript.jsx']}
      let g:user_emmet_settings = {
      \  'javascript.jsx': {
      \      'extends': 'jsx',
      \  },
      \}

      " match tags in html, similar to paren support
      Plug 'gregsexton/MatchTag', { 'for': 'html' }
  " }}}

  " TypeScript {{{
      Plug 'ianks/vim-tsx', { 'for': 'typescript' }
      Plug 'Shougo/vimproc.vim', { 'do': 'make' }

      Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
      let g:nvim_typescript#max_completion_detail=100
      let g:nvim_typescript#diagnostics_enable=0
  " }}}

  Plug 'sheerun/vim-polyglot'
  " Startify: Fancy startup screen for vim {{{
    Plug 'mhinz/vim-startify'

    " Don't change to directory when selecting a file
    let g:startify_files_number = 5
    let g:startify_change_to_dir = 0
    let g:startify_custom_header = [ ]
    let g:startify_relative_path = 1
    let g:startify_use_env = 1

    function! s:list_commits()
        let git = 'git -C ' . getcwd()
        let commits = systemlist(git . ' log --oneline | head -n5')
        let git = 'G' . git[1:]
        return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
    endfunction

    " Custom startup list, only show MRU from current directory/project
    let g:startify_lists = [
    \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
    \  { 'type': function('s:list_commits'), 'header': [ 'Recent Commits' ] },
    \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
    \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
    \  { 'type': 'commands',  'header': [ 'Commands' ]       },
    \ ]

    let g:startify_commands = [
    \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
    \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
    \ ]

    " let g:startify_bookmarks = [
    "     \ { 'c': '~/code/dotfiles/config/nvim/init.vim' },
    "     \ { 'z': '~/code/dotfiles/zsh/zshrc.symlink' }
    " \ ]

    autocmd User Startified setlocal cursorline
" }}}
call plug#end()

" FZF settings
let g:fzf_nvim_statusline = 0 " disable statusline overwriting
nmap ; :Buffers<CR>
nmap <C-p> :Files<CR>
nmap <C-t> :Tags<CR>

" Gruvbox settings
syntax enable
set background=dark
colorscheme gruvbox


" Language Server Settings
" Required for operations modifying multiple buffers like rename.
set hidden

" Emmet Settings
let g:user_emmet_leader_key='<C-y>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}


" Use ag over grep
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
set grepprg=ag\ --nogroup\ --nocolor


" Airline settings
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled = 1


" NERDTree
map <C-n> :NERDTreeToggle<CR>


