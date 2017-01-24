alias ag='ag --hidden'

alias gt='git tag'
alias gsur='git submodule update --remote --merge'
alias gpo='git push origin'
alias gpom='git push origin master'
alias grso="git remote show origin | grep Fetch | awk '{print \$3}'"
function gbC () {echo $(git_current_branch) | pbcopy}
function gcoff () { 
  local TOCHECKOUT=$(git branch -a | fzf)
  TOCHECKOUT=${TOCHECKOUT// /}
  git checkout $TOCHECKOUT
}
function gmff () { 
  local TOCHECKOUT=$(git branch -a | fzf)
  TOCHECKOUT=${TOCHECKOUT// /}
  git merge $TOCHECKOUT
}
function glpff () {
  local REVISION=$(git log --pretty=oneline | fzf | cut -d ' ' -f 1)
  echo $REVISION
  git show $REVISION | vim -
}
function gitlab () {
  local GITLAB_URL="$(grso | rev | cut -c 5- | rev)/blob/$(git_current_branch)/$(fzf)"
  echo $GITLAB_URL copied to the clipboard
  echo $GITLAB_URL | pbcopy
}
function glomd () {
  echo "**$(git_current_branch)**"
  local urlPre=$(git remote show origin | grep Fetch | cut -d' ' -f 5 | sed 's/\.git//')"/commit/"
  git log --format=format:"- [%s]($urlPre%H)" $@
}
function ggrb() { 
    git fetch origin 
    git rebase origin/$(git_current_branch)
}
function ggrbm {
    if [ -z $1 ] ; then
        local branch="master"
    else
        local branch=$1
    fi
    git fetch origin
    git checkout $branch
    ggrb
    git checkout -
    git rebase $branch
}

alias git-branch-ordered="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname) %(committerdate) %(authorname)' | sed 's/refs\/heads\///g' | head -n"
alias gpad='echo "➜ git checkout atmire-DEV" && git checkout atmire-DEV && echo "➜ git fetch" && git fetch && echo "➜ git pull" && git pull && echo "➜ git merge --no-edit -" && git merge --no-edit - && echo "➜ git push origin atmire-DEV" && git push origin atmire-DEV && echo "➜ git checkout - " &&git checkout -'
alias gpm='echo "➜ git checkout master" && git checkout master && echo "➜ git fetch" && git fetch && echo "➜ git pull" && git pull && echo "➜ git merge --no-edit -" && git merge --no-edit - && echo "➜ git push origin master" && git push origin master && echo "➜ git checkout - " &&git checkout -'

alias echopath="echo $PATH | tr -s ':' '\n'"
alias ant_update='cd . && ant clean_backups && ant update -Doverwrite=true'
alias grep="grep --color=auto"
alias remote_debug_java_opts_on='export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xmx512m -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5004"'
alias remote_debug_java_opts_off='export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xmx512m"'
alias npm-exec='PATH=$(npm bin):$PATH'
alias tmux="TERM=screen-256color-bce tmux"

alias xit='fortune' #when e..xit breaks due to a broken pipe

alias -g C='| pbcopy'
alias -g H='| head -n'
alias -g T='| tail -n'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g N="> /dev/null 2> /dev/null"

# docker build -t vim-antoine .
#alias v='docker run -ti --rm -v $(pwd):/home/developer/workspace vim-antoine'


function findmod() {
    find $1 -type f -exec stat --format '%Y :%y %n' "{}" \; | sort -nr | cut -d: -f2-
}

function history_stats() {
    history | cut -c 8- | grep "^$1" | cut -f 1 -d " " | sort | uniq -c | sort -bgr 
}
