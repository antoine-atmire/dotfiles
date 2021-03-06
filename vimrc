set encoding=utf-8
scriptencoding utf-8
nnoremap é @
let g:mapleader = ' '

if has('unix')
    let s:uname = system('uname')
    if s:uname ==? 'Darwin\n'
        " Do Mac stuff here
        "let g:pathogen_disabled = ['YouCompleteMe']
    endif
endif

syntax enable
filetype plugin indent on

packadd! matchit

packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('SirVer/ultisnips')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/gv.vim')
call minpac#add('junegunn/vim-slash')
call minpac#add('machakann/vim-columnmove')
call minpac#add('romainl/vim-qlist')
call minpac#add('shumphrey/fugitive-gitlab.vim')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vim-utils/vim-man')
call minpac#add('w0rp/ale')
call minpac#add('wellle/tmux-complete.vim')

" call minpac#add('neoclide/coc.nvim')

" elm
call minpac#add('ElmCast/elm-vim')
call minpac#add('antoine-atmire/vim-elmc')
" call minpac#add('antew/vim-elm-analyse')

" typescript
call minpac#add('leafgarland/typescript-vim')
call minpac#add('Shougo/vimproc.vim')
call minpac#add('Quramy/tsuquyomi')

" rust
call minpac#add('rust-lang/rust.vim')

" clojure
" call minpac#add('eraserhd/parinfer-rust')
" call minpac#add('kien/rainbow_parentheses.vim')
" call minpac#add('tpope/vim-classpath')
" call minpac#add('tpope/vim-fireplace')
" call minpac#add('tpope/vim-salve')
" call minpac#add('venantius/vim-cljfmt')

" call minpac#add('morhetz/gruvbox')

" move vertically visually and not line-wise (for wrapped lines)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

vnoremap <bs> h

set laststatus=0 "2 is always
set showcmd
" set number
" set relativenumber
" set ruler
set scrolloff=10
set scrolljump=-30
set completeopt=noinsert,noselect,menuone
set complete-=i
set softtabstop=4
set shiftwidth=4
set expandtab
" set modelines=0
set ignorecase
set smartcase
set incsearch
set hlsearch
" wait a little longer when leader is pressed
" set timeoutlen=2000
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
" set cursorline
" set cursorcolumn
set autoread
set showbreak=↪\ 
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:␣,space:␣,eol:$

set mouse=n
set mouse+=v

" use project specific .vimrc
set exrc
" must be used when using exrc
set secure

if exists('$SUDO_USER')
    set noundofile
    set noswapfile
    set nobackup
else
    set nobackup
    set backupcopy=yes
    set backupdir=/tmp
    call system('mkdir $HOME/.vim/.swapfiles')
    set swapfile
    set directory=$HOME/.vim/.swapfiles
    call system('mkdir $HOME/.vim/.undo')
    set undofile
    set undodir=$HOME/.vim/.undo
    set undolevels=1000
    set undoreload=10000
endif

set statusline=%y " file type
set statusline+=\ %f " relative file path
set statusline+=\ %L\ lines "total lines
set statusline+=\ %l:%v " current line:column
" set statusline+=\ %{ALEGetStatusLine()}
" ALEGetStatusLine doesn't exist anymore

" define a group `vimrc` and initialize.
augroup vimrc
  autocmd!
  "clears all events so they don't happen twice when reloading vimrc
augroup END

" " Custom StatusLine colors
" autocmd vimrc InsertEnter * highlight StatusLine ctermbg=0 ctermfg=3
" autocmd vimrc InsertLeave * highlight StatusLine ctermbg=None ctermfg=0
" autocmd vimrc ColorScheme * highlight StatusLine ctermbg=None ctermfg=0


" only show colorcolumns for lines that are longer
call matchadd('ColorColumn', '\%81v', 100)
" iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
autocmd vimrc ColorScheme * highlight ColorColumn ctermbg=237 ctermfg=2

function! HighlightLines()
    silent! call matchdelete(51)
    if line('.') > 10
        call matchadd('RelativeLine', '\%'.(line('.') - 10).'l\%1v', 100, 51)
    endif
    silent! call matchdelete(52)
    call matchadd('RelativeLine', '\%'.(line('.') + 10).'l\%1v', 100, 52)
endfunction
" autocmd vimrc CursorMoved * call HighlightLines()
autocmd vimrc ColorScheme * highlight RelativeLine ctermbg=8
nnoremap <c-p> 10k
nnoremap <c-k> 10k
nnoremap <c-n> 10j
nnoremap <c-j> 10j

" use background from terminal, not from colorscheme
autocmd vimrc ColorScheme * highlight Normal ctermbg=None

autocmd vimrc ColorScheme * highlight CursorColumn ctermbg=235
autocmd vimrc ColorScheme * highlight CursorLine ctermbg=235
autocmd vimrc ColorScheme * highlight CursorLineNr ctermbg=235

" Change Color when entering Insert Mode
autocmd vimrc InsertEnter * highlight CursorLine ctermbg=None
autocmd vimrc InsertEnter * highlight CursorColumn ctermbg=None

" Revert Color to default when leaving Insert Mode
autocmd vimrc InsertLeave * highlight CursorLine ctermbg=235
autocmd vimrc InsertLeave * highlight CursorColumn ctermbg=235

autocmd vimrc ColorScheme * highlight ALEErrorLine ctermbg=None ctermfg=1
autocmd vimrc ColorScheme * highlight ALEWarningLine ctermbg=None ctermfg=3

autocmd vimrc ColorScheme * highlight! link String Statement
autocmd vimrc ColorScheme * highlight Normal ctermfg=7

" useful mapping when trying out commands
nnoremap <leader>:: Y:@"<cr>
nnoremap <leader>:; dd:@"<cr>


set background=dark
" set background=light

let g:gruvbox_invert_selection = 0

" source ~/.vimrc_background
" colorscheme molokai
" colorscheme gruvbox
" colorscheme apprentice
colorscheme fahrenheit


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
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>et :e ~/.tmux.conf<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>
nnoremap <leader>em :e ~/.m2/settings.xml<cr>
nnoremap <leader>ee :e<cr>
nnoremap <leader>ew :e /tmp/w2p<cr>
" from https://github.com/mhinz/vim-galore#quickly-edit-your-macros
" Use it like this <leader>eq or "q<leader>eq 
nnoremap <leader>eq  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
" fix a miss typed search with the above trick
nmap <leader>en "/<leader>eq
" help in a tab
nnoremap <leader>h :tab help<space>
" grep word under cursor
nnoremap <leader>gg :silent grep <c-r><c-w><cr>
nnoremap <leader>gy :silent grep <c-r>"<cr>
nnoremap <leader>r :source $MYVIMRC<cr>
nnoremap <leader>q @
" new line with spaces until the cursor
nnoremap <leader>o y0opVr $a
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
" nnoremap <leader>ct :AsyncRun ctags -R<space>
" nnoremap <leader>ag :w<cr>:AsyncRun tmux send-keys -t 0 C-c Enter "glol -12 %:p" Enter<cr>
nnoremap <leader>ag :!git log --abbrev-commit --pretty='\%Cred\%h\%Creset -\%C(yellow)\%d\%Creset \%s \%Cgreen(\%cr) \%C(bold blue)<\%an>\%Creset' -12 %:p<cr>
" send current paragaph to tmux pane
nmap <leader>aa yip<leader>ay
" delete current line and send it to tmux pane
nmap <leader>ad dd<leader>ay
" copy yanked text to tmux pane
nnoremap <leader>ay :silent ! tmux send-keys -t 0 "<c-r>=
            \substitute(
            \substitute(
            \substitute(
            \substitute(
            \substitute(
            \substitute(@",'"','\\"','g')
            \,'\s\s\s*','','g')
            \,'\n','" Enter "','g')
            \,'!','\\!','g')
            \,'%','\\%','g')
            \,'#','\\#','g')
            \<cr>" Enter<cr><c-l>
" also escape ; (for sql prompts)
nnoremap <leader>as yip:silent ! tmux send-keys -t 0 "<c-r>=
            \substitute(
            \substitute(
            \substitute(
            \substitute(
            \substitute(
            \substitute(
            \substitute(@",'"','\\"','g')
            \,'\s\s\s*','','g')
            \,'\n','" Enter "','g')
            \,'!','\\!','g')
            \,'%','\\%','g')
            \,'#','\\#','g')
            \,';','\\;','g')
            \<cr>" Enter<cr><c-l>
" send current line (for vimgolf)
nmap <leader>av 0yg_:silent ! tmux send-keys -t 0 "<c-r>=
            \substitute(
            \substitute(
            \substitute(
            \substitute(
            \substitute(
            \substitute(@",'"','\\"','g')
            \,'\s\s\s*','','g')
            \,'\n','" Enter "','g')
            \,'!','\\!','g')
            \,'%','\\%','g')
            \,'#','\\#','g')
            \<cr>"<cr><c-l>
" list of buffers, ready to choose one by number
nnoremap <leader>m :buffers<cr>:b
" go to the previous buffer. [N]ctrl-^ (qwerty: ctrl-6)
" nnoremap <leader><tab> :buffer #<cr>
" go to the next double empty lines
nnoremap <leader>} }/\n\n\n/3<cr>:let @/=''<cr>
vnoremap <leader>} }/\n\n\n/1<cr>
" go to the previous double empty lines
nnoremap <leader>{ {?\n\n\n?1<cr>:let @/=''<cr>
vnoremap <leader>{ {?\n\n\n?1<cr>
nnoremap <leader>pp "+p
vnoremap <leader>pp "+p
" set current working directory to the parent of the current buffer
nnoremap <leader>cd :cd %:p:h
" wrap curent line in ()
nnoremap (( mMI(<esc>A)<esc>`M
" wrap the rest of the line in ()
nnoremap )) mMi(<esc>A)<esc>`M
" to clear the hlsearch
nnoremap <leader>/ :let @/=''<cr>
" wrap the line so far in ()
nnoremap () mMI(<esc>`Mla)<esc>
nnoremap <leader>- :e %:h<cr>
nnoremap <leader><tab> :e#<cr>

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
vnoremap <leader>/ y/<c-r>"
vnoremap <leader>y "+y
nnoremap <leader>y "+y


" insert mode mappings
" check what NOT to remap:
" https://www.reddit.com/r/vim/comments/4w0lib/do_you_use_insert_mode_keybindings/
"
" use jk as escape in insert mode, to actually type jk: type j<c-v>k
" removed because the autocomplete interferres too often
" inoremap jk <esc><bs>l
" when you're on ^ and don't want want to go up a line
" inoremap jj <esc>
" inoremap <c-j> <C-o>:echo "use control ["
" ZZZ in insert mode will also save and quit
" just so you don't have to correct yourself when accidentally typing ZZ in
" insert mode
inoremap ZZZ <esc>ZZ

" xml tags (taken from ragtag)
inoremap <c-x>t <esc>ciW<lt><c-r>"></<C-R>"><Esc>F<i
inoremap <c-x><cr> <esc>ciW<lt><c-r>"><cr><cr></<C-R>"><Esc>-i
" wrap the last word in spaces so the xml-tag mapping can work on it
inoremap <c-x><space> <esc>vbc <c-r>" <left>
" go to last xml attribute location
inoremap <c-l>a <esc>?><cr>i

inoremap <c-x>" <esc>ciW"<c-r>""

" close brackets and place cursor inside
" inoremap (c ()<esc>i
" inoremap [c []<esc>i
" inoremap {c {}<esc>i


" operator pending mode mapping
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
" autocmd vimrc CursorHold,CursorHoldI,BufLeave ?* silent update
"if you remove this one day, you may consider set hidden
" Undo all changes since opening buffer in vim
nnoremap <leader>zq :u1<bar>u


" location list mappings
nnoremap <leader>lc :lclose<cr>
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>lg :silent lgrep<space>

" quickfix mappings
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>cg :silent grep<space>


" command abbreviations
cnoremap ~~ /tmp/

let g:indentLine_char = '│'
let g:indentLine_color_term = 235
                
" plugin configuration

let g:fugitive_gitlab_domains = ['https://git.atmire.com']

" ale plugin
set signcolumn=no
let g:ale_sign_column_always = 0
let g:ale_sign_error = '>>'
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_virtualtext_cursor = 1
let g:ale_elm_analyse_use_global = 1

nnoremap ]<c-a> :ALENext<cr>
nnoremap [<c-a> :ALEPrevious<cr>
nnoremap _a :ALEDetail<cr>

let g:ale_linters = {}
let g:ale_fixers = {}

" let g:ale_linters_ignore = {'typescript': ['tslint']}

" use prettier through ale
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['java'] = ['prettier']
let g:ale_javascript_prettier_options = '--single-quote --tab-width=4'
autocmd vimrc FileType typescript nnoremap <leader>pe :ALEFix<cr>
autocmd vimrc FileType javascript nnoremap <leader>pe :ALEFix<cr>
autocmd vimrc FileType java nnoremap <leader>pe :ALEFix<cr>

let g:ale_linters['elm'] = ['make']

let g:ale_linters['java'] = []

let g:ale_linters['haskell'] = ['hlint', 'hdevtools', 'hfmt']
let g:ale_fixers['haskell'] = ['hfmt']

" tsuquyomi 
let g:tsuquyomi_disable_quickfix=1
let g:tsuquyomi_disable_default_mappings=1
autocmd vimrc FileType typescript nnoremap <buffer> <c-t> :TsuquyomiGoBack<cr>
autocmd vimrc FileType typescript nnoremap <buffer> <c-]> :TsuquyomiDefinition<cr>
autocmd vimrc FileType typescript nnoremap <buffer> <leader>6 :TsuquyomiReferences<cr>

" vim-js-pretty-template
" autocmd vimrc FileType javascript JsPreTmpl html
" autocmd vimrc FileType typescript JsPreTmpl html
" autocmd vimrc FileType typescript syn clear foldBraces " For leafgarland/typescript-vim users only.

let g:UltiSnipsExpandTrigger = '<C-j>'

" vim-slash
if has('timers')
  " Blink 1 times with 400ms interval
  noremap <expr> <plug>(slash-after) slash#blink(1, 400)
endif


" columnmove
xmap [v <Plug>(columnmove-b)
xmap ]v <Plug>(columnmove-w)
nmap [v <Plug>(columnmove-b)
nmap ]v <Plug>(columnmove-w)


" end plugin configuration

" fzf config
set runtimepath+=~/.fzf

" Open (non-ignored) file in directory
if executable('ag')
    command! FuzzyFile call fzf#run({
                \ 'source':'/usr/local/bin/ag --hidden --ignore .git -g ""',
                \ 'sink':'e',
                \ 'options':'--preview "cat {}" --preview-window="up"'
                \ })
    command! FuzzyFilePrint call fzf#run({
                \ 'source':'/usr/local/bin/ag --hidden --ignore .git -g ""',
                \ 'sink':'norm o',
                \ })
else
    command! FuzzyFile call fzf#run({
                \ 'source':'find . -not -path "*/node_modules/*" -not -path "*/.git/*"',
                \  'sink':'e'
                \ })
endif
nnoremap <leader>ff :FuzzyFile<cr>
nnoremap <leader>fi :FuzzyFilePrint<cr><<o<esc>"%p-<c-v>jI'<esc><c-v>j$A'<esc>Ji,<esc>A)<esc>Iimport os.path; print os.path.relpath(<esc>V:!python<cr>:silent s:\.ts<cr>df/

" the more idiomatic way which works without external tools:
" usage: <leader>t part-of-file-name <c-d><tab><c-n><c-n>...
nnoremap <leader>t :e **/*

" keep build artifacts out of the completion 
" (the files we don't ever want to load in vim)
set wildignore+=**/target/**
set wildignore+=**/overlays/**
set wildignore+=**/node_modules/**

" wildmenu enables an interactive completion menu for <tab> when there are
" multiple matches. So <c-d> can be skipped and we don't have to wait for the
" completion twice.
set wildmenu
set wildmode=list:longest,list:full

" Go to tag
nnoremap <leader>ft :Tags<cr>
nnoremap <leader>gt :tjump<space>/*<left>

" " Search lines in all open vim buffers
" function! s:line_handler(l)
"     let keys = split(a:l, ':\t')
"     exec 'buf' keys[0]
"     exec keys[1]
"     normal! ^zz
" endfunction
" function! s:buffer_lines()
"     let res = []
"     for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
"         call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
"     endfor
"     return res
" endfunction
" command! FuzzyLines call fzf#run({
"             \   'source':  <sid>buffer_lines(),
"             \   'sink':    function('<sid>line_handler'),
"             \   'options': '--extended --nth=3..',
"             \   'down':    '60%'
"             \})
" nnoremap <leader>fl :FuzzyLines<cr>
nnoremap <leader>gl :g//#<Left><Left>

"Open buffer by name
function! s:buflist()
    redir => l:ls
    silent ls
    redir END
    return split(l:ls, '\n')
endfunction
function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction
command! FuzzyBuffer call fzf#run({
            \   'source':  reverse(<sid>buflist()),
            \   'sink':    function('<sid>bufopen'),
            \   'options': '+m',
            \   'down':    len(<sid>buflist()) + 2
            \ })
nnoremap <leader>fb :FuzzyBuffer<cr>

" " FZF + UltiSnips
nnoremap <leader>fs :Snippets<cr>

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

" https://vimrcfu.com/snippet/265
" Open the location/quickfix window automatically if there are valid entries in the list.
augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

" Use :Grep instead of :grep! and :LGrep instead of :lgrep!.
" :cgetexpr and :lgetexpr are much faster than :grep and :lgrep
" and they don't mess with your terminal emulator.
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr system(&grepprg . ' ' . shellescape(<q-args>))
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr system(&grepprg . ' ' . shellescape(<q-args>))


" undotree plugin
nnoremap <leader>u :UndotreeToggle<cr>


" rainbow bracket plugin
" let g:rbpt_max = 16
" autocmd vimrc VimEnter * RainbowParenthesesToggle
" autocmd vimrc Syntax * RainbowParenthesesLoadRound

" elm setup
let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 0

" go to the definition of the function under the cursoer
" Ilist is the ilist variant from romainl/vim-qlist
autocmd vimrc FileType elm nnoremap <buffer> <leader>] yiw:Ilist \s<c-r>"\s.*=$<cr>

" I add .elm at the end so Html.elm is not skipped when the directory Html/
" exists in the same directory...
" I also remove matches in VirtualDom directories
function! GetElmFilenameFix(word)
    let l:word = a:word
    if match(l:word, 'VirtualDom') >= 0
        let l:word = ''
    else
        " replace module dots with slash
        let l:word = substitute(l:word,'\.','/','g') .'.elm'
    endif
    return l:word
endfunction
autocmd vimrc FileType elm setlocal includeexpr=GetElmFilenameFix(v:fname)



" " https://www.reddit.com/r/vim/comments/5yhlpc/had_an_idea/
" function! GoToEndOfTextObject(...)
"     normal! `]
" endfunction
" nnoremap <silent> ]a :set operatorfunc=GoToEndOfTextObject<cr>g@a
" nnoremap <silent> ]i :set operatorfunc=GoToEndOfTextObject<cr>g@i
" function! GoToStartOfTextObject(...)
"     normal! `[
" endfunction
" nnoremap <silent> [a :set operatorfunc=GoToStartOfTextObject<cr>g@a
" nnoremap <silent> [i :set operatorfunc=GoToStartOfTextObject<cr>g@i

" nnoremap <silent> [m :set operatorfunc=GoToStartOfTextObject<cr>g@
" nnoremap <silent> ]m :set operatorfunc=GoToEndOfTextObject<cr>g@

function! OpFuncVisualSelection(type, aCommand)
    let l:sel_save = &selection
    let &selection = 'inclusive'
    let l:reg_save = @@

    let l:command = 'normal! '
    if a:0  " Invoked from Visual mode, use gv command.
        let l:command.='gv'
    elseif a:type ==# 'V' || a:type ==? '\<c-v>'
        let l:command.='gv'
    elseif a:type ==? 'line'
        let l:command.='`[V`]'
    else
        let l:command.='`[v`]'
    endif

    let l:command.=a:aCommand

    " echom a:type . " " . l:command
    silent exe l:command

    let &selection = l:sel_save
    let @@ = l:reg_save
endfunction

function! SelectMotion(type, ...)
    call OpFuncVisualSelection(a:type, '')
endfunction
nnoremap <silent> <leader>v :set operatorfunc=SelectMotion<cr>g@
vnoremap <silent> <leader>v :<c-u>call SelectMotion(visualmode(), 1)<cr>

function! SelectMotionLineWise(type, ...)
    call OpFuncVisualSelection('line', '')
endfunction
nnoremap <silent> <leader>V :set operatorfunc=SelectMotion<cr>g@
vnoremap <silent> <leader>V :<c-u>call SelectMotion(visualmode(), 1)<cr>

" function! ReplaceByDashes(type, ...)
"     call OpFuncVisualSelection(a:type, 'r-')
" endfunction
" nnoremap <silent> <leader>gt :set operatorfunc=ReplaceByDashes<cr>g@
" vnoremap <silent> <leader>gt :<c-u>call ReplaceByDashes(visualmode(), 1)<cr>

function! ExtractVariable(type, ...)
    call OpFuncVisualSelection(a:type, "sceestar\<esc>Oceestar = \<esc>p^")
endfunction
nnoremap <silent> <leader>ge :set operatorfunc=ExtractVariable<cr>g@
vnoremap <silent> <leader>ge :<c-u>call ExtractVariable(visualmode(), 1)<cr>

function! OpFuncDuplicate(type, ...)
    call OpFuncVisualSelection(a:type, 'y`]p')
endfunction
nnoremap <silent> <leader>d :set operatorfunc=OpFuncDuplicate<cr>g@
vnoremap <silent> <leader>d :<c-u>call OpFuncDuplicate(visualmode(), 1)<cr>

function! OpFuncDuplicateOnNewLine(type, ...)
    call OpFuncVisualSelection(a:type, "y`]a\<cr>\<cr>\<esc>kp")
endfunction
nnoremap <silent> <leader>D :set operatorfunc=OpFuncDuplicateOnNewLine<cr>g@
vnoremap <silent> <leader>D :<c-u>call OpFuncDuplicateOnNewLine(visualmode(), 1)<cr>


" atomist-rugs
autocmd vimrc BufNewFile,BufRead *.rug setlocal ft=typescript
autocmd vimrc BufNewFile,BufRead *.rt setlocal ft=typescript

" create non existing parent directories on save
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let l:dir=fnamemodify(a:file, ':h')
        if !isdirectory(l:dir)
            call mkdir(l:dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
" make list-like commands more intuitive
function! CCR()
    let l:cmdtype = getcmdtype()
    if l:cmdtype ==# ':'
        let l:cmdline = getcmdline()
        if l:cmdline =~# '\v\C^(ls|files|buffers)'
            " like :ls but prompts for a buffer command
            return "\<CR>:b"
        elseif l:cmdline =~# '\v\C/(#|nu|num|numb|numbe|number)$'
            " like :g//# but prompts for a command
            return "\<CR>:"
        elseif l:cmdline =~# '\v\C^(dli|il)'
            " like :dlist or :ilist but prompts for a count for :djump or :ijump
            return "\<CR>:" . l:cmdline[0] . 'j  ' . split(l:cmdline, ' ')[1] . "\<S-Left>\<Left>"
        elseif l:cmdline =~# '\v\C^(cli|lli)'
            " like :clist or :llist but prompts for an error/location number
            return "\<CR>:sil " . repeat(l:cmdline[0], 2) . "\<Space>"
        " why not use :bro old (browse oldfiles)
        " elseif l:cmdline =~# '\C^old'
            " like :oldfiles but prompts for an old file to edit
            " set nomore
            " return "\<CR>:sil se more|e #<"
        elseif l:cmdline =~# '\C^changes'
            " like :changes but prompts for a change to jump to
            set nomore
            return "\<CR>:sil se more|norm! g;\<S-Left>"
        elseif l:cmdline =~# '\C^ju'
            " like :jumps but prompts for a position to jump to
            set nomore
            return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
        elseif l:cmdline =~# '\C^marks'
            " like :marks but prompts for a mark to jump to
            return "\<CR>:norm! `"
        elseif l:cmdline =~# '\C^undol'
            " like :undolist but prompts for a change to undo
            return "\<CR>:u "
        else
            return "\<CR>"
        endif
    else
        return "\<CR>"
    endif
endfunction
cnoremap <expr> <CR> CCR()

nnoremap <leader>` :marks<cr>:norm! `
nnoremap <leader><c-o> :set nomore<cr>:jumps<cr>:set more<bar>norm! <S-left>

" from: http://vim.wikia.com/wiki/Indent_text_object
" Changes to allow blank lines in blocks, and
" Top level blocks (zero indent) separated by two or more blank lines.
" Usage: source <thisfile> 
" Press: vai, vii to select outer/inner blocks by indetation.
" Press: vii, yii, dii, cii to select/yank/delete/change an indented block.
onoremap <silent>ai :<C-u>call IndTxtObj(0)<CR>
onoremap <silent>ii :<C-u>call IndTxtObj(1)<CR>
vnoremap <silent>ai <Esc>:call IndTxtObj(0)<CR><Esc>gv
vnoremap <silent>ii <Esc>:call IndTxtObj(1)<CR><Esc>gv

function! IndTxtObj(inner)
    let l:curcol = col('.')
    let l:curline = line('.')
    let l:lastline = line('$')
    let l:i = indent(line('.'))
    if getline('.') !~# '^\\s*$'
        let l:p = line('.') - 1
        let l:pp = line('.') - 2
        let l:nextblank = getline(l:p) =~# '^\\s*$'
        let l:nextnextblank = getline(l:pp) =~# '^\\s*$'
        while l:p > 0 && ((l:i == 0 && (!l:nextblank || (l:pp > 0 && !l:nextnextblank))) || (l:i > 0 && ((indent(l:p) >= l:i && !(l:nextblank && a:inner)) || (l:nextblank && !a:inner))))
            -
            let l:p = line('.') - 1
            let l:pp = line('.') - 2
            let l:nextblank = getline(l:p) =~# '^\\s*$'
            let l:nextnextblank = getline(l:pp) =~# '^\\s*$'
        endwhile
        normal! 0V
        call cursor(l:curline, l:curcol)
        let l:p = line('.') + 1
        let l:pp = line('.') + 2
        let l:nextblank = getline(l:p) =~# '^\\s*$'
        let l:nextnextblank = getline(l:pp) =~# '^\\s*$'
        while l:p <= l:lastline && ((l:i == 0 && (!l:nextblank || l:pp < l:lastline && !l:nextnextblank)) || (l:i > 0 && ((indent(l:p) >= l:i && !(l:nextblank && a:inner)) || (l:nextblank && !a:inner))))
            +
            let l:p = line('.') + 1
            let l:pp = line('.') + 2
            let l:nextblank = getline(l:p) =~# '^\\s*$'
            let l:nextnextblank = getline(l:pp) =~# '^\\s*$'
        endwhile
        normal! $
    endif
endfunction


" https://vim.fandom.com/wiki/Auto_highlight_current_word_when_idle
" autosave delay, cursorhold trigger, default: 4000ms
setl updatetime=300
" highlight the word under cursor (CursorMoved is inperformant)
highlight WordUnderCursor cterm=underline gui=underline
autocmd CursorHold * call HighlightCursorWord()
function! HighlightCursorWord()
    " if hlsearch is active, don't overwrite it!
    let search = getreg('/')
    let cword = expand('<cword>')
    if match(cword, search) == -1
        exe printf('match WordUnderCursor /\V\<%s\>/', escape(cword, '/\'))
    endif
endfunction
