" colorscheme apprentice
colorscheme fahrenheit

" define a group `vimrc` and initialize.
augroup vimrc
  autocmd!
  "clears all events so they don't happen twice when reloading vimrc
augroup END

" gui tweaking
set guioptions -=m "removes the menubar
set guioptions -=T "removes the toolbar
set guioptions -=b "removes the bottom scrollbar
set guioptions -=r "removes the right scrollbar
set guioptions -=l "removes the left scrollbar
set guioptions -=R "removes the right scrollbar (split)
set guioptions -=L "removes the left scrollbar (split)
set guifont=Consolas:h11:cANSI

" all around settings
set ignorecase "/search is case insensitive 
set smartcase "unless a capital letter is used
set hidden "allow unsaved changes when leaving a buffer
set scrolloff=999
set breakindent

" use project specific .vimrc
set exrc
" must be used when using exrc
set secure

" essential keymappings
let mapleader = " "
nnoremap <leader>r :source $MYVIMRC<cr>
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>ee :edit<cr>
nnoremap <leader>w :wa<cr>
nnoremap <leader>h :tab help 
nnoremap <leader>m :buffers<cr>:b
nnoremap <leader>t :e **/*
nnoremap <leader>cd :cd %:p:h
nnoremap <leader>g :silent lgrep <c-r><c-w><cr>
nnoremap <leader>pp "+p
vnoremap <leader>pp "+p
nnoremap <leader>y "+y
vnoremap <leader>y "+y
" from https://github.com/mhinz/vim-galore#quickly-edit-your-macros
" Use it like this <leader>eq or "q<leader>eq 
nnoremap <leader>eq  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
nmap <leader>en "/<leader>eq

" move vertically visually and not line-wise (for wrapped lines)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" useful mapping when trying out commands
nnoremap <leader>:: Y:@"<cr>
nnoremap <leader>:; dd:@"<cr>

" remove bindings
nnoremap Q @@
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

" swap and undo settings
set swapfile
set directory=$HOME/vimfiles/swapfiles
set undofile
set undodir=$HOME/vimfiles/undo
set undolevels=1000
set undoreload=10000

" location list mappings
nnoremap <leader>lc :lclose<cr>
nnoremap <leader>lo :lopen<cr>

" quickfix mappings
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>

" ale plugin
let g:ale_sign_column_always = 1
let g:ale_sign_error = '! '
let g:ale_sign_warning = '? '
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0

" elm plugin
let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 0

set grepprg=C:/ripgrep/ripgrep-0.6.0-x86_64-pc-windows-msvc/rg.exe\ --vimgrep
set grepformat=%f:%l:%c:%m

" tsuquyomi 
let g:tsuquyomi_disable_quickfix=1
let g:tsuquyomi_disable_default_mappings=1
autocmd FileType typescript nnoremap <buffer> <c-t> :TsuquyomiGoBack<cr>
autocmd FileType typescript nnoremap <buffer> <c-]> :TsuquyomiDefinition<cr>
autocmd FileType typescript nnoremap <buffer> <leader>6 :TsuquyomiReferences<cr>
set scrolloff=999

" create non existing parent directories on save
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
" replace current word and go to the next occurrence (n. combo)
nnoremap c* *Ncgn
" same as above for visual selections
let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"
vnoremap <expr> c* g:mc . "``cgn"

" keep build artifacts out of the completion 
" (the files we don't ever want to load in vim)
set wildignore+=**/target/**,**/overlays/**

" wildmenu enables an interactive completion menu for <tab> when there are
" multiple matches. So <c-d> can be skipped and we don't have to wait for the
" completion twice.
set wildmenu
