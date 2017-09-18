colorscheme apprentice

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

" essential keymappings
let mapleader = " "
nnoremap <leader>r :source $MYVIMRC<cr>
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>ee :edit<cr>
nnoremap <leader>w :wa<cr>
nnoremap <leader>h :tab help 
nnoremap <leader>m :buffers<cr>:buffer<space>
nnoremap <leader>e* :e **/*
nnoremap <leader>cd :cd %:p:h
nnoremap <leader>g :silent lgrep <c-r><c-w><cr>

" move vertically visually and not line-wise (for wrapped lines)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" useful mapping when trying out commands
nnoremap <leader>:: Y:@"<cr>
nnoremap <leader>:; dd:@"<cr>

" remove bindings
nnoremap Q <nop>
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
let g:ale_sign_column_always = 0
let g:ale_sign_error = '→'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" asyncrun
nnoremap <leader>am :w<cr>:make<cr>
"nnoremap <leader>am :w<cr>:AsyncRun make<cr>
"set autoread "reloads file when it changes on disk
"autocmd User AsyncRunStop * checktime "makes autoread actually work


set grepprg=C:/ripgrep/ripgrep-0.6.0-x86_64-pc-windows-msvc/rg.exe\ --vimgrep
set grepformat=%f:%l:%c:%m

" tsuquyomi 
let g:tsuquyomi_disable_quickfix=1
let g:tsuquyomi_disable_default_mappings=1
autocmd FileType typescript nnoremap <buffer> <c-t> :TsuquyomiGoBack<cr>
autocmd FileType typescript nnoremap <buffer> <c-]> :TsuquyomiDefinition<cr>
autocmd FileType typescript nnoremap <buffer> <leader>6 :TsuquyomiReferences<cr>
