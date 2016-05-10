let g:pathogen_disabled = ['nerdtree']
execute pathogen#infect()
syntax on
filetype plugin indent on

set encoding=utf-8
set nocompatible
set laststatus=2
set statusline+=%F
set showcmd
set number
set relativenumber
set ruler
set scrolloff=10
set cursorline
set completeopt=longest,menuone
set tabstop=2
set shiftwidth=2
set expandtab
set modelines=0

colorscheme molokai

map <silent> <C-p> :NERDTreeToggle<CR>
map <silent> <Leader>f ::NERDTreeFind<CR>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" \ev - edit .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" \r - reload .vimrc
nnoremap <leader>r :so $MYVIMRC<cr>
" \q - @ 
nnoremap <leader>q @
" new line with spaces until the cursor
nnoremap <leader>n y0opVr $


" auto save on FocusLost
autocmd CursorHold,CursorHoldI * update
" Undo all changes since opening buffer in vim
nnoremap <leader>zq :u1<bar>u

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']

nnoremap <leader>s :w<bar>SyntasticCheck

" command-t
let g:CommandTWildIgnore=&wildignore . ",**/overlays/**,**/target/**"
