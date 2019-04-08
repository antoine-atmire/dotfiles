setlocal formatprg=rustfmt
nnoremap <buffer> <leader>pe mMgggqG`M

" aq - cargo run
nnoremap <leader>aq :w<cr>:silent ! tmux send-keys -t 0 C-c Enter "cargo run" Enter<cr><c-l>
