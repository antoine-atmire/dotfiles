noremap é @ "let mapleader = ","
let mapleader = " "

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " Do Mac stuff here
        "let g:pathogen_disabled = ['YouCompleteMe']
    endif
endif
execute pathogen#infect()
" silent! execute pathogen#helptags()
syntax on
filetype plugin indent on

" move vertically visually and not line-wise (for wrapped lines)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

set encoding=utf-8
set nocompatible
set laststatus=2
set showcmd
" set number
" set relativenumber
set ruler
set scrolloff=999
set scrolljump=-30
set completeopt=longest,menuone
set tabstop=4
set shiftwidth=4
set expandtab
set modelines=0
set ignorecase
set smartcase
set incsearch
" wait a little longer when leader is pressed
set timeoutlen=2000
set confirm "confirmation dialog when closing a file with changes
set backspace=indent,eol,start
set breakindent
set formatoptions+=j "remove comment leader when joining lines
set nojoinspaces "don't add double space when joining lines after . ! ...
set shortmess+=A "no swapfile warning
set shiftround  " When at 3 spaces, and I hit > ... go to 4, not 5
set hidden
set lazyredraw
set scroll=15 "number of lines to scroll for c-u and c-d
set cursorline
set cursorcolumn

" use project specific .vimrc
set exrc
" must be used when using exrc
set secure

if exists('$SUDO_USER')
    set noundofile
    set noswapfile
    set nobackup
else
    set noswapfile
    set nobackup
    " set backupcopy=yes "maybe add a set backupdir ?
    " enable undofile swapfile and set their dirs ?
    " set noundofile
    set undofile
    set undodir=$HOME/.vim/.undo
    set undolevels=1000
    set undoreload=10000
endif

set statusline=%y " file type
set statusline+=\ %f " relative file path
set statusline+=\ %L\ lines "total lines
set statusline+=\ %l:%v " current line:column
set statusline+=\ %{ALEGetStatusLine()}

" Custom StatusLine colors
autocmd InsertEnter * highlight StatusLine ctermbg=0 ctermfg=3
autocmd InsertLeave * highlight StatusLine ctermbg=None ctermfg=0
autocmd ColorScheme * highlight StatusLine ctermbg=None ctermfg=0

" only show colorcolumns for lines that are longer
call matchadd('ColorColumn', '\%81v', 100)
" iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
autocmd ColorScheme * highlight ColorColumn ctermbg=7 ctermfg=0

" use background from terminal, not from colorscheme
autocmd ColorScheme * highlight Normal ctermbg=None

autocmd ColorScheme * highlight CursorColumn ctermbg=235
autocmd ColorScheme * highlight CursorLine ctermbg=235
autocmd ColorScheme * highlight CursorLineNr ctermbg=235

" useful mapping when trying out commands
nnoremap <leader>:: Y:@"<cr>
nnoremap <leader>:; dd:@"<cr>


set background=dark
" set background=light

let g:gruvbox_invert_selection = 0

" colorscheme molokai
colorscheme gruvbox
" colorscheme Apprentice


nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" save all buffers
nnoremap <leader>w :wa<cr>
" \ev - edit .vimrc
"nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>et :tabe ~/.tmux.conf<cr>
nnoremap <leader>ez :tabe ~/.zshrc<cr>
nnoremap <leader>em :tabe ~/.m2/settings.xml<cr>
nnoremap <leader>ee :e<cr>
nnoremap <leader>el :tabe ../local-settings.xml<cr>
" help in a tab
nnoremap <leader>h :tab help<space>
" grep word under cursor
nnoremap <leader>g :lgrep <c-r><c-w><cr>
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
nnoremap Q @@
nnoremap <leader>= mMgg=G`M
" highlight last inserted text
nnoremap gV `[v`]
" pretty-print selected xml, px 'pretty xml'
vnoremap <leader>px !xmllint --format -<CR>
" split on &, not 'nore' because this is recursive, pq 'pretty query'
nmap <leader>pq 0f&r<leader>pq
" ctags command
" nnoremap <leader>ct :!ctags -R<space>
nnoremap <leader>ct :AsyncRun ctags -R<space>
" list of buffers, ready to choose one by number
nnoremap <leader>m :buffers<cr>:buffer<space>
" go to the previous buffer. [N]ctrl-^ (qwerty: ctrl-6)
" nnoremap <leader><tab> :buffer #<cr>
" go to the next double empty lines
nnoremap <leader>} }/\n\n\n/1<cr>
" go to the previous double empty lines
nnoremap <leader>{ {?\n\n\n?1<cr>
" let's automatically go into vim-mode command line
" nnoremap : :<c-f>i
nnoremap <leader>pp "+p

" http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
" replace current word and go to the next occurrence (n. combo)
nnoremap c* *Ncgn
" same as above for visual selections
let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"
vnoremap <expr> c* g:mc . "``cgn"

" for commits on w2p-12345_xxx branches
nnoremap <leader>cw :r !git branch<cr><c-v>gg:v:*:d<cr>gg2xf_C:<space>

" my own "unimpaired" mappings
nnoremap [o9 :set scrolloff=999<cr>
nnoremap ]o9 :set scrolloff=1<cr>
" I'd make a co9 to toggle, but I don't know how

" Keep selection after indent/unindent
vnoremap < <gv
vnoremap > >gv
" search for selected text
vnoremap / y/<c-r>"
vnoremap <leader>y "+y
vnoremap <c-j> <esc>


" insert mode mappings
" check what NOT to remap:
" https://www.reddit.com/r/vim/comments/4w0lib/do_you_use_insert_mode_keybindings/
"
" use jk as escape in insert mode, to actually type jk: type j<c-v>k
" removed because the autocomplete interferres too often
" inoremap jk <esc><bs>l
" when you're on ^ and don't want want to go up a line
" inoremap jj <esc>
inoremap <c-j> <esc>
" ZZZ in insert mode will also save and quit
" just so you don't have to correct yourself when accidentally typing ZZ in
" insert mode
inoremap ZZZ <esc>ZZ
" xml tags (taken from ragtag)
inoremap <c-x>t <esc>ciW<lt><c-r>"></<C-R>"><Esc>F<i
inoremap <c-x><cr> <esc>ciW<lt><c-r>"><cr><cr></<C-R>"><Esc>-i
" wrap the last word in spaces so the xml-tag mapping can work on it
inoremap <c-f> <esc>vbc <c-r>" <left>
" go to last xml attribute location
inoremap <c-l>a <esc>?><cr>i
" close brackets and place cursor inside
" inoremap (c ()<esc>i
" inoremap [c []<esc>i
" inoremap {c {}<esc>i


" operator pending mode mappping
" works with y, d, c, =, ... not v (use <leader>v as defined further below)
" :help omap-info

" custom-line
onoremap <silent> cl :<c-u>normal! ^v$h<cr>

" All file
onoremap <silent> A :<c-u>normal! ggvG$<cr>

" java inner method
onoremap <silent> im :<c-u>normal! <bs>]Mv[m<cr>

" java outer method
onoremap <silent> am :<c-u>normal! <bs>]Mv[m{<cr>

" 1 line context
onoremap <silent> C :<c-u>normal! k0v2j$<cr>


" auto save on FocusLost
" autocmd CursorHold,CursorHoldI,BufLeave ?* silent update
"if you remove this one day, you may consider set hidden
" Undo all changes since opening buffer in vim
nnoremap <leader>zq :u1<bar>u


" location list mappings
nnoremap <leader>lc :lclose<cr>
nnoremap <leader>lo :lopen<cr>

" quickfix mappings
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>


" command abbreviations
cnoremap ~~ /tmp/


"completor plugin
" let g:completor_auto_trigger = 0
let g:completor_min_chars = 4

" ale plugin
let g:ale_sign_column_always = 0
let g:ale_sign_error = '→'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" tsuquyomi 
let g:tsuquyomi_disable_quickfix=1
let g:tsuquyomi_disable_default_mappings=1
autocmd FileType typescript nnoremap <buffer> <c-t> :TsuquyomiGoBack<cr>
autocmd FileType typescript nnoremap <buffer> <c-]> :TsuquyomiDefinition<cr>
autocmd FileType typescript nnoremap <buffer> <leader>6 :TsuquyomiReferences<cr>



" vim-js-pretty-template
autocmd FileType javascript JsPreTmpl html
autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces " For leafgarland/typescript-vim users only.

let g:UltiSnipsExpandTrigger = '<C-y>'


" Denite (replaces Unite)
nnoremap <leader>db :Denite buffer<cr>
nnoremap <leader>dm :Denite file_mru<cr>
nnoremap <leader>dl :Denite line<cr>
nnoremap <leader>dc :Denite colorscheme<cr>
nnoremap <leader>dq :Denite command<cr>
nnoremap <leader>dg :Denite grep<cr>
" nnoremap <leader>dh :Denite help<cr> "I would use <leader>h<cr><leader>ff anyway
nnoremap <leader>dd :Denite menu<cr>
nnoremap <leader>dt :Denite filetype<cr>

let s:menus = {}

let s:menus.dotfiles = {
            \ 'description': 'Edit your dotfiles'
            \ }
let s:menus.dotfiles.file_candidates = [
            \ ['vimrc', '~/.vimrc'],
            \ ['tmux.conf', '~/.tmux.conf'],
            \ ['zshrc', '~/.zshrc'],
            \ ['profile', '~/.profile'],
            \ ['m2/settings.xml', '~/.m2/settings.xml'], 
            \ ['snippets', '~/.vim/UltiSnips/'],
            \ ['zazurc', '~/.zazurc.json']
            \ ]
let s:menus.project = {
            \ 'description': 'Edit your project dotfiles'
            \ }
let s:menus.project.file_candidates = [
            \ ['vimrc - project', '.vimrc'],
            \ ['.git/info/exclude', '.git/info/exclude'],
            \ ['local-settings.cfg', '../local-settings.cfg'],
            \ ['local.properties', 'local.properties'],
            \ ]


call denite#custom#var('menu', 'menus', s:menus)



set rtp+=~/.fzf

nnoremap <leader>ff :call fzf#run({'source':"sed '/^\\!/d;s/\t.*//' ".join(tagfiles()),'sink':'tag', 'right':'50%'})<cr>
nnoremap <leader>fc :call fzf#run({'source': map(split(globpath(&rtp, 'colors/*.vim')), 'fnamemodify(v:val, ":t:r")'), 'sink': 'colo', 'left': '35%'})<cr>
nnoremap <leader>frr :call fzf#run({'source':'/usr/local/bin/ag --hidden --ignore .git -g ""', 'sink':'norm o'})<cr>

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


" elm setup
let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 0
" elm keybindings
nnoremap <leader>pe :ElmFormat<cr>
" autocmd FileType elm nnoremap <leader>pe <Plug>(elm-make)

if has("conceal")
    " set conceallevel otherwise it doesn't do anything
    setlocal conceallevel=2
    " specify modes in which to use the conceal feature: cnvi
    setlocal concealcursor=c

    nnoremap <leader>c0 :setlocal conceallevel=0<cr>
    nnoremap <leader>c1 :setlocal conceallevel=1<cr>
    nnoremap <leader>c2 :setlocal conceallevel=2<cr>
    nnoremap <leader>c3 :setlocal conceallevel=3<cr>

    autocmd FileType elm syntax match arrowRight /->/ conceal cchar=➛
    autocmd FileType elm syntax match greaterThan />=/ conceal cchar=≧
    autocmd FileType elm syntax match lessThan /<=/ conceal cchar=≦
    autocmd FileType elm syntax match elmLambda /\\/ conceal cchar=λ
    autocmd FileType elm syntax match elmPipeRight /|>/ conceal cchar=▶
    autocmd FileType elm syntax match elmPipeLeft /<|/ conceal cchar=◀

    "autocmd BufnewFile,BufRead,BufWrite *  syntax match arrowLeft /<!-/ conceal cchar=← "this breaks xml comment highlighting
    "autocmd BufnewFile,BufRead,BufWrite * syntax match lessThan /==/ conceal cchar==
    "autocmd BufnewFile,BufRead,BufWrite * syntax match lessThan /===/ conceal cchar=≡
    "autocmd BufnewFile,BufRead,BufWrite * syntax match doubleDash /--/ conceal cchar=−
endif

" gruvbox tuning for elm
highlight! link elmType GruvBoxYellow
highlight! link elmTypedef GruvBoxRed
highlight! link elmImport GruvBoxRed

" keymappings primarly for elm
" pretty cases
nmap <leader>pc ^dt,Op==<<A ->wx<leader>pc


" https://www.reddit.com/r/vim/comments/5yhlpc/had_an_idea/
function! GoToEndOfTextObject(...)
    normal! `]
endfunction
nnoremap <silent> ]a :set operatorfunc=GoToEndOfTextObject<cr>g@a
nnoremap <silent> ]i :set operatorfunc=GoToEndOfTextObject<cr>g@i

function! GoToStartOfTextObject(...)
    normal! `[
endfunction
nnoremap <silent> [a :set operatorfunc=GoToStartOfTextObject<cr>g@a
nnoremap <silent> [i :set operatorfunc=GoToStartOfTextObject<cr>g@i

nnoremap <silent> [m :set operatorfunc=GoToStartOfTextObject<cr>g@
nnoremap <silent> ]m :set operatorfunc=GoToEndOfTextObject<cr>g@

function! OpFuncVisualSelection(type, aCommand)
	  let sel_save = &selection
	  let &selection = "inclusive"
	  let reg_save = @@

      let l:command = "normal! "
	  if a:0  " Invoked from Visual mode, use gv command.
          let l:command.="gv"
      elseif a:type == 'V' || a:type == "\<c-v>"
          let l:command.="gv"
	  elseif a:type == 'line'
          let l:command.="`[V`]"
	  else
          let l:command.="`[v`]"
	  endif

      let l:command.=a:aCommand

      " echom a:type . " " . l:command
      silent exe l:command

	  let &selection = sel_save
	  let @@ = reg_save
endfunction

function! SelectMotion(type, ...)
    call OpFuncVisualSelection(a:type, "")
endfunction
nnoremap <silent> <leader>v :set operatorfunc=SelectMotion<cr>g@
vnoremap <silent> <leader>v :<c-u>call SelectMotion(visualmode(), 1)<cr>

function! SelectMotionLineWise(type, ...)
    call OpFuncVisualSelection("line", "")
endfunction
nnoremap <silent> <leader>V :set operatorfunc=SelectMotion<cr>g@
vnoremap <silent> <leader>V :<c-u>call SelectMotion(visualmode(), 1)<cr>

function! ReplaceByDashes(type, ...)
    call OpFuncVisualSelection(a:type, "r-")
endfunction
nnoremap <silent> <leader>gt :set operatorfunc=ReplaceByDashes<cr>g@
vnoremap <silent> <leader>gt :<c-u>call ReplaceByDashes(visualmode(), 1)<cr>

function! ExtractVariable(type, ...)
    call OpFuncVisualSelection(a:type, "sceestar\<esc>Oceestar = \<esc>p^")
endfunction
nnoremap <silent> <leader>ge :set operatorfunc=ExtractVariable<cr>g@
vnoremap <silent> <leader>ge :<c-u>call ExtractVariable(visualmode(), 1)<cr>

function! OpFuncDuplicate(type, ...)
    call OpFuncVisualSelection(a:type, "y`]p")
endfunction
nnoremap <silent> <leader>gd :set operatorfunc=OpFuncDuplicate<cr>g@
vnoremap <silent> <leader>gd :<c-u>call OpFuncDuplicate(visualmode(), 1)<cr>

function! OpFuncDuplicateOnNewLine(type, ...)
    call OpFuncVisualSelection(a:type, "y`]a\<cr>\<cr>\<esc>kp")
endfunction
nnoremap <silent> <leader>gD :set operatorfunc=OpFuncDuplicateOnNewLine<cr>g@
vnoremap <silent> <leader>gD :<c-u>call OpFuncDuplicateOnNewLine(visualmode(), 1)<cr>


" atomist-rugs
autocmd BufNewFile,BufRead *.rug setlocal ft=typescript
autocmd BufNewFile,BufRead *.rt setlocal ft=typescript


" ideas

" gundo.vim plugin
" (not convinced yet, but I guess I need to try before making up my mind)
" noremap <leader>u :GundoToggle<CR>
"
" https://github.com/t9md/vim-quickhl
" https://github.com/benizi/vim-automkdir
" https://github.com/google/vim-searchindex
