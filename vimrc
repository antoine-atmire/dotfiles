" azerty shortcuts
noremap é @
"let mapleader = ","

let g:pathogen_disabled = ['command-t']

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
    " command-t and YCM seem to be mutually exclusive on mac os x
    " but I replaced command-t by fzf so it seems to be fine now
		"let g:pathogen_disabled = ['YouCompleteMe']
  endif
endif
execute pathogen#infect()
syntax on
filetype plugin indent on

set encoding=utf-8
set nocompatible
set laststatus=2
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
"set paste
"set list
set exrc
set secure

set statusline+=%y " file type
set statusline+=\ %f " relative file path
set statusline+=\ %l/%L " total lines
set statusline+=\ %v " column number

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
" resync syntax highlighting
noremap <F5> <Esc>:syntax sync fromstart<cr>
inoremap <F5> <C-o>:syntax sync fromstart<cr>
" let's not stumble into ex mode
nnoremap Q <nop>

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
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint', 'tsuquyomi']
"let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:syntastic_typescript_tsc_fname = ''

nnoremap <leader>s :w<bar>SyntasticCheck<cr>

" command-t
let g:CommandTWildIgnore=&wildignore . ",**/overlays/**,**/target/**,**/node_modules/*,**/node_modules/**"

" integrate tsuquyomi with syntastic
let g:tsuquyomi_disable_quickfix = 1

" vim-js-pretty-template
autocmd FileType javascript JsPreTmpl html
autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces " For leafgarland/typescript-vim users only.

let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<C-n>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>', '<C-p>']
let g:UltiSnipsExpandTrigger = '<C-y>'

" Unite
"nnoremap <C-m> :Unite file file_rec/git:--cached:--others:--exclude-standard file_mru<cr>
nnoremap <leader>a :Unite grep:.<cr>
nnoremap <leader>ff :Unite file<cr>
nnoremap <leader>m :Unite file_mru<cr>
" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --hidden'
  let g:unite_source_grep_recursive_opt = ''
endif

set rtp+=~/.fzf
"nnoremap <leader>t :call fzf#run({'source':'find . -not -path "*/node_modules/*" -not -path "*/.git/*"', 'sink':'e'})<cr>
nnoremap <leader>t :call fzf#run({'source':'/usr/bin/ag -g ""', 'sink':'e'})<cr>
