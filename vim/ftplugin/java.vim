set makeprg=make\ --silent
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
nnoremap <buffer> <leader>am :w<cr>:silent make<cr><c-l>
nnoremap <leader>aq :w<cr>:silent ! tmux send-keys -t 0 "make bounce --silent" Enter<cr><c-l>
nnoremap <leader>ar :silent ! tmux send-keys -t 0 "make run --silent" Enter<cr><c-l>

nnoremap <silent> <leader>gm :set operatorfunc=ExtractJavaMethod<cr>g@
vnoremap <silent> <leader>gm :<c-u>call ExtractJavaMethod(visualmode(), 1)<cr>

function! ExtractJavaMethod(type, ...)
    call OpFuncVisualSelection(a:type, "sceestar\<esc>]M\<cr>o ceestar { return \<esc>pa; }\<esc>I")
endfunction
