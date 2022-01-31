
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" reconfigure keys
inoremap jk <Esc>
let mapleader = "\<Space>"

" LEADER commands
nmap <leader>so :source $MYVIMRC<cr> " Source vimrc


" NvimTree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" Packages
call plug#begin('~/.vim/plugged') 
call plug#end()