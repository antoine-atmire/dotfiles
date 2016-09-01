# AVIT ZSH Theme

dswhich() {
  if [ -n "$DSNAME" ]; then
    echo " {$DSNAME}"
  fi
}

PROMPT='
$(_user_host)$( _current_dir ) $(git_prompt_info) $(_ruby_version) $(dswhich)
%{$fg[$CARETCOLOR]%}>>%{$resetcolor%} '

PROMPT2='%{$fg[$CARETCOLOR]%}<<%{$reset_color%} '

RPROMPT='$(_vi_status)%{$(echotc UP 1)%}$(_git_time_since_commit) $(git_prompt_status) ${_return_status}%{$(echotc DO 1)%}'

local _current_dir="%{$fg_bold[blue]%}%5~%{$reset_color%} "
local _return_status="%{$fg_bold[red]%}%(?..⍉)%{$reset_color%}"
local _hist_no="%{$fg[grey]%}%h%{$reset_color%}"

function _current_dir() {
  local _max_pwd_length="65"
  if [[ $(echo -n $PWD | wc -c) -gt ${_max_pwd_length} ]]; then
    echo "%{$fg_bold[blue]%}%-2~ ... %3~%{$reset_color%} "
  else
    echo "%{$fg_bold[blue]%}%~%{$reset_color%} "
  fi
}

function _user_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$fg[cyan]%}$me%{$reset_color%}:"
  fi
}

function _vi_status() {
  if {echo $fpath | grep -q "plugins/vi-mode"}; then
    echo "$(vi_mode_prompt_info)"
  fi
}

function _ruby_version() {
  if {echo $fpath | grep -q "plugins/rvm"}; then
    echo "%{$fg[grey]%}$(rvm_prompt_info)%{$reset_color%}"
  elif {echo $fpath | grep -q "plugins/rbenv"}; then
    echo "%{$fg[grey]%}$(rbenv_prompt_info)%{$reset_color%}"
  fi
}

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
# Only proceed if there is actually a commit.
  if git log -1 > /dev/null 2>&1; then
    # Get the last commit.
    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals
    minutes=$((seconds_since_last_commit / 60))
    hours=$((seconds_since_last_commit/3600))

    # Sub-hours and sub-minutes
    days=$((seconds_since_last_commit / 86400))
    sub_hours=$((hours % 24))
    sub_minutes=$((minutes % 60))

    if [ $hours -gt 24 ]; then
      commit_age="${days}d"
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m"
    else
      commit_age="${minutes}m"
    fi

    color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL
    echo "$color$commit_age%{$reset_color%}"
  fi
}

# from https://raw.githubusercontent.com/tnwinc/omz-git/master/omz-git.plugin.zsh
# with my own modifications
function git_prompt_info() {
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git name-rev --name-only --no-undefined --always HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    ref="$(command echo ${ref#refs/heads/})"
    length=${#ref}

    maxLength=$(command git config --get oh-my-zsh.max-branch-length 2>/dev/null)
    if [[ -z ${maxLength} ]]; then
      maxLength=30
    fi


    if [[ ${length} -gt ${maxLength} ]]; then
      regex=$(command git config --get oh-my-zsh.prefix-regex 2>/dev/null)
      if [[ -n ${regex} ]]; then
        ref=$(command echo ${ref} | sed "s/${regex}//1" ) #${regex})
      fi

      prefixLength=$(command git config --get oh-my-zsh.prefix-length 2>/dev/null)
      if [[ -z ${prefixLength} ]]; then
        prefixLength=0
      fi
      if [[ ${prefixLength} -gt 0 ]]; then
        prefix=$(command echo ${ref} | cut -c ${prefixLength})
        ref=$(command echo ${ref} | cut -c `expr ${prefixLength} + 1`-)
        length=${#ref}
      fi
    fi
    if [[ ${length} -gt ${maxLength} ]]; then
      suffixLength=$(command git config --get oh-my-zsh.suffix-length 2>/dev/null)
      if [[ -z ${suffixLength} ]]; then
        suffixLength=0
      fi

      length=${#ref}
      suffixStart=`expr ${length} - ${suffixLength} + 1`
      separatorLength=3 #3 dots...
      nameEnd=`expr ${maxLength} - ${suffixLength} - ${separatorLength}`
      ref="$(command echo ${ref} | cut -c 1-${nameEnd})...$(command echo ${ref} | cut -c ${suffixStart}-)"
    fi

    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

if [[ $USER == "root" ]]; then
  CARETCOLOR="red"
else
  CARETCOLOR="white"
fi

MODE_INDICATOR="%{$fg_bold[yellow]%}❮%{$reset_color%}%{$fg[yellow]%}❮❮%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[white]%}"

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLOR='1;33'
