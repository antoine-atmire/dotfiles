" azerty shortcuts
noremap é @
let mapleader = ","

" command-t and YCM seem to be mutually exclusive on mac os x
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
		let g:pathogen_disabled = ['YouCompleteMe']
  endif
endif
execute pathogen#infect()
syntax on
filetype plugin indent on

set encoding=utf-8
set nocompatible
set laststatus=2
set statusline+=%f
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
set colorcolumn=80
set ignorecase
set paste

colorscheme molokai

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
" copy all lines to clipboard
nnoremap <leader>cx gg"+yG

" auto save on FocusLost
autocmd CursorHold,CursorHoldI ?* silent update
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
let g:syntastic_javascript_checkers = ['jshint', 'tsuquyomi']

nnoremap <leader>s :w<bar>SyntasticCheck<cr>

" command-t
let g:CommandTWildIgnore=&wildignore . ",**/overlays/**,**/target/**"

" integrate tsuquyomi with syntastic
let g:tsuquyomi_disable_quickfix = 1

" vim-js-pretty-template
autocmd FileType javascript JsPreTmpl html
autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces " For leafgarland/typescript-vim users only.
