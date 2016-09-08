export PATH=$PATH:$HOME/bin

if [ -f $HOME/.profile ]; then
  source $HOME/.profile
fi
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
