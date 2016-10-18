# esc-e to <c-x><c-e>
bindkey "^[e" edit-command-line
# bindkey "^[r" does not work but the line below does exactly that...
bindkey -s "\er" "source ~/.zshrc^J"

# function to make ctrl-z suspend _and_ resume
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^z' fg-bg
