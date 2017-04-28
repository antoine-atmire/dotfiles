function dswhich() {
  if [ -n "$DSNAME" ]; then
    echo "%{$fg[magenta]%}$DSNAME%{$reset_color%} "
  fi
}

function git_prompt_info_minimal() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$(parse_git_dirty)"
  fi
}

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%} "

PROMPT_INDICATOR="%{$fg[magenta]%}$%{$reset_color%}"

PROMPT='$(dswhich)$(git_prompt_info_minimal)$PROMPT_INDICATOR '
