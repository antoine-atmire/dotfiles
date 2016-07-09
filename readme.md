I'm still new to vim and tmux. These configs may not be optimal.

Install fzf in ~/.fzf (or link it there)
try `<leader>t`

Install **jshint** for **syntastic**:
`npm install -g jshint`

Make vimproc:
* `cd ~/.vim/bundle/vimproc.vim`
* `make`

Install YouCompleteMe:
* `brew install cmake` / `sudo apt-get install build-essential cmake python-dev python3-dev`
* `cd vim/bundle/YouCompleteMe`
* `./install.py --tern-completer`
