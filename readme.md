I'm still new to vim and tmux. These configs may not be optimal.

`git submodule update --init --recursive`

To compile **command-t** (on mac):
* `ruby --version` #ruby 1.9.3p484
* `brew install vim`
* `vim --version`
* and inside vim `:ruby puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"` #1.9.3p484

if it matches you're good to proceed:
* `cd vim/bundle/command-t/ruby/command-t`
* `ruby extconf.rb`
* `make`
* and inside vim: `:call pathogen#helptags()`

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
