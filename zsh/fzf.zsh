[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# lastpass cli integration
function lpff() {
  lpass show -c --password $(lpass ls  | fzf | awk '{print $(NF)}' | sed 's/\]//g')
}
