noremap é @
"let mapleader = ","
let mapleader = " "

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
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
"set cursorline
set completeopt=longest,menuone
set tabstop=2
set shiftwidth=2
set expandtab
set modelines=0
set colorcolumn=80
set ignorecase
set smartcase
"set paste
" wait a little longer when leader is pressed
set timeoutlen=3000
set confirm "confirmation dialog when closing a file with changes
set backspace=indent,eol,start
set breakindent
set formatoptions+=j "remove comment leader when joining lines
set nojoinspaces "don't add double space when joining lines after . ! ...
set shortmess+=A "no swapfile warning
set shiftround  " When at 3 spaces, and I hit > ... go to 4, not 5

" use project specific .vimrc
set exrc
" must be used when using exrc
set secure

if exists('$SUDO_USER')
  set noundofile
  set noswapfile
  set nobackup
else
  set backupcopy=yes "maybe add a set backupdir ?
  " enable undofile swapfile and set their dirs ?
endif

set statusline=%y " file type
set statusline+=\ %f " relative file path
set statusline+=\ %L\ lines "total lines
set statusline+=\ %l:%v " current line:column
set statusline+=\ %{ALEGetStatusLine()}

set background=dark

"colorscheme molokai
colorscheme gruvbox
"colorscheme base16-default-dark

" use jk as escape in insert mode, to actually type jk: type j -wait- type k
inoremap jk <esc><bs>l
" ZZZ in insert mode will also save and quit
" just so you don't have to correct yourself when accidentally typing ZZ in
" insert mode
inoremap ZZZ <esc>ZZ
"this happens quite enough to warrant a mapping
nnoremap <leader>w :w<cr>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" \ev - edit .vimrc
"nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>et :tabe ~/.tmux.conf<cr>
nnoremap <leader>ez :tabe ~/.zshrc<cr>
nnoremap <leader>ee :e<cr>
" help in a tab
nnoremap <leader>h :tab help 
" \r - reload .vimrc
nnoremap <leader>r :source $MYVIMRC<cr>
" \q - @ 
nnoremap <leader>q @
" new line with spaces until the cursor
nnoremap <leader>o y0opVr $
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
" pretty-print selected xml, px 'pretty xml'
vmap <leader>px !xmllint --format -<CR>
" split on &, not 'nore' because this is recursive, pq 'pretty query'
nmap <leader>pq 0f&r<leader>pq
" toggle relativenumber
nnoremap <leader>n :set relativenumber!<cr>
" replace current word and go to the next occurrence (n. combo)
nnoremap c* *Ncgn
" ctags command
nnoremap <leader>ct :!ctags -R 

" auto save on FocusLost
autocmd CursorHold,CursorHoldI ?* silent update
"if you remove this one day, you may consider set hidden
" Undo all changes since opening buffer in vim
nnoremap <leader>zq :u1<bar>u

" Keep selection after indent/unindent
vnoremap < <gv
vnoremap > >gv


nnoremap <leader>lc :lclose<cr>
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>lf :lfirst<cr>
"nnoremap <leader>le :ElmErrorDetail<cr>
nnoremap <leader>pe :ElmFormat<cr>
nnoremap <leader>le :call ale_linters#elm#make#MessageDetails()<cr>


" ale plugin
let g:ale_sign_column_always = 1
let g:ale_sign_error = '→'

" integrate tsuquyomi with syntastic
let g:tsuquyomi_disable_quickfix = 1

" vim-js-pretty-template
autocmd FileType javascript JsPreTmpl html
autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces " For leafgarland/typescript-vim users only.

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

nnoremap <leader>ff :call fzf#run({'source':"sed '/^\\!/d;s/\t.*//' ".join(tagfiles()),'sink':'tag', 'right':'50%'})<cr>
nnoremap <leader>fc :call fzf#run({'source': map(split(globpath(&rtp, 'colors/*.vim')), 'fnamemodify(v:val, ":t:r")'), 'sink': 'colo', 'left': '35%'})<cr>

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
  set grepprg=ag\ --vimgrep\ --hidden\ --ignore\ .git
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

let g:elm_setup_keybindings = 0
let g:elm_syntastic_show_warnings = 1
let g:elm_format_autosave = 1


if has("conceal")
  " set conceallevel otherwise it doesn't do anything
  setlocal conceallevel=2
  " specify modes in which to use the conceal feature: cnvi
  setlocal concealcursor=cnv

  nnoremap <leader>c0 :setlocal conceallevel=0<cr>
  nnoremap <leader>c1 :setlocal conceallevel=1<cr>
  nnoremap <leader>c2 :setlocal conceallevel=2<cr>
  nnoremap <leader>c3 :setlocal conceallevel=3<cr>

  autocmd BufnewFile,BufRead,BufWrite *  syntax match arrowRight /->/ conceal cchar=→
  autocmd BufnewFile,BufRead,BufWrite * syntax match greaterThan />=/ conceal cchar=≧
  autocmd BufnewFile,BufRead,BufWrite * syntax match lessThan /<=/ conceal cchar=≦
  autocmd BufnewFile,BufRead,BufWrite *  syntax match arrowLeft /<!-/ conceal cchar=←
  "autocmd BufnewFile,BufRead,BufWrite * syntax match lessThan /==/ conceal cchar==
  "autocmd BufnewFile,BufRead,BufWrite * syntax match lessThan /===/ conceal cchar=≡
  "autocmd BufnewFile,BufRead,BufWrite * syntax match doubleDash /--/ conceal cchar=−
  autocmd BufnewFile,BufRead,BufWrite * syntax match elmLambda /\\/ conceal cchar=λ
  autocmd BufnewFile,BufRead,BufWrite * syntax match elmPipeRight /|>/ conceal cchar=▶
  autocmd BufnewFile,BufRead,BufWrite * syntax match elmPipeLeft /<|/ conceal cchar=◀
endif

" gruvbox tuning for elm
hi! link elmType GruvBoxYellow
hi! link elmTypedef GruvBoxRed
hi! link elmImport GruvBoxRed


" ideas

" gundo.vim plugin (not convinced yet, but I guess I need to try before
" making up my mind)
" noremap <leader>u :GundoToggle<CR>
"
" switch to vim8 with these goodies
" https://github.com/skywind3000/asyncrun.vim (I'm thinking <leader>! :AsyncRun )
" https://github.com/maralla/completor.vim ( to replace YCM ) -- done
" https://github.com/w0rp/ale.git (to replace
" syntastichttps://github.com/w0rp/ale.git (to replace syntastic)
