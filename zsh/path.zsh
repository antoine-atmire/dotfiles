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
"$HOME/.local/bin"
"$HOME/.rvm/bin"
"$HOME/.rvm/sbin"
"$HOME/.yarn/bin"
"$HOME/.cabal/bin"
"$HOME/.cargo/bin"
"$HOME/dotfiles/bin"
)

NEW_PATH=""

for dir in ${(k)dirs_to_include[@]}
do
    if [ -d ${dir} ]; then
        echo $NEW_PATH | grep -q -s ${dir}
        if [ $? -eq 1 ] ; then
            NEW_PATH="${dir}:$NEW_PATH"
        fi
    fi
done

unset dirs_to_prepend

export PATH=$NEW_PATH


# load .profile
if [ -f $HOME/.profile ]; then
  source $HOME/.profile
fi

export NVM_DIR="$HOME/.nvm"
function loadnvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}
