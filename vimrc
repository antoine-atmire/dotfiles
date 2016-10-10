" azerty shortcuts
noremap é @
"let mapleader = ","
let mapleader = " "

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

" move vertically visually and not line-wise (for wrapped lines)
nnoremap j gj
nnoremap k gk

set encoding=utf-8
set nocompatible
set laststatus=2
set showcmd
set number
set relativenumber
set ruler
"set scrolloff=10
set scrolloff=999
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
set backupcopy=yes
" wait a little longer when leader is pressed
set timeoutlen=3000


" use project specific .vimrc
set exrc
" must be used when using exrc
set secure


set statusline=%y " file type
set statusline+=\ %f " relative file path
set statusline+=\ line\ %l/%L " total lines
set statusline+=\ col\ %v " column number

set background=dark

"colorscheme molokai
colorscheme gruvbox

" use jk as escape in insert mode, to actually type jk: type j -wait- type k
inoremap jk <esc> 
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
"nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>ev :new $MYVIMRC<cr>
nnoremap <leader>ez :new ~/.zshrc<cr>
" \r - reload .vimrc
nnoremap <leader>r :source $MYVIMRC<cr>
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
nnoremap <leader>= gg=G<c-o><c-o>
" when space is leader the default won't work
nnoremap <leader>cv <Plug>NERDCommenterToggle
" highlight last inserted text
nnoremap gV `[v`]


" auto save on FocusLost
autocmd CursorHold,CursorHoldI ?* silent update
" Undo all changes since opening buffer in vim
nnoremap <leader>zq :u1<bar>u




" syntastic
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint', 'tsuquyomi']
"let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:syntastic_typescript_tsc_fname = ''
" custom syntastic mappings
nnoremap <leader>ss :w<bar>SyntasticCheck<cr>
nnoremap <leader>so :Errors<cr>
nnoremap <leader>sc :lclose<cr>
nnoremap <leader>sn :lnext<cr>
nnoremap <leader>sp :lprevious<cr>
nnoremap <leader>se :ElmErrorDetail<cr>


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
let g:ycm_semantic_triggers = {
     \ 'elm' : ['.'],
     \}

let g:UltiSnipsExpandTrigger = '<C-y>'

" Unite
"nnoremap <C-m> :Unite file file_rec/git:--cached:--others:--exclude-standard file_mru<cr>
nnoremap <leader>a :Unite grep:.<cr>
"nnoremap <leader>ff :Unite file<cr>
nnoremap <leader>m :Unite file_mru<cr>
nnoremap <leader><tab> :Unite file_mru<cr>j

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --hidden'
  let g:unite_source_grep_recursive_opt = ''
endif

set rtp+=~/.fzf

nnoremap <leader>ff :call fzf#run({'source':"sed '/^\\!/d;s/\t.*//' ".join(tagfiles()),'sink':'tag'})<cr>

"if executable('rg')
"nnoremap <leader>t :call fzf#run({'source':'/usr/local/bin/rg --files --hidden .', 'sink':'e'})<cr>
"elseif executable('ag')
if executable('ag')
  nnoremap <leader>t :call fzf#run({'source':'/usr/local/bin/ag --hidden --ignore .git -g ""', 'sink':'e'})<cr>
else
  nnoremap <leader>t :call fzf#run({'source':'find . -not -path "*/node_modules/*" -not -path "*/.git/*"', 'sink':'e'})<cr>
endif

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
"if executable('ag')
  set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

let g:elm_setup_keybindings = 0
let g:elm_syntastic_show_warnings = 1
let g:elm_format_autosave = 1



" ideas

" gundo.vim plugin  
" noremap <leader>u :GundoToggle<CR>
