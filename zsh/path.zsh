declare -a dirs_to_include
dirs_to_include=(
"/bin"
"/sbin"
"/usr/bin"
"/usr/sbin"
"/usr/local/bin"
"/usr/local/sbin"
"$HOME/bin"
"$HOME/sbin"
"$HOME/.rvm/bin"
"$HOME/.rvm/sbin"
"$HOME/.yarn/bin"
"$HOME/dotfiles/bin"
)

# If these directories exist and are not included yet,
# then prepend them to existing PATH
for dir in ${(k)dirs_to_include[@]}
do
  if [ -d ${dir} ]; then
    echo $PATH | grep -q -s ${dir}
    if [ $? -eq 1 ] ; then
      PATH="$PATH:${dir}"
    fi
  fi
done

unset dirs_to_prepend

export PATH


# load .profile
if [ -f $HOME/.profile ]; then
  source $HOME/.profile
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

