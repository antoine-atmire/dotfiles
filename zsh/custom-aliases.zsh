alias ag='ag --hidden --ignore .git'

alias gt='git tag'
alias gsur='git submodule update --remote --merge'
alias gpo='git push origin'
alias gpom='git push origin master'
alias grso="git remote show origin | grep Fetch | awk '{print \$3}'"
alias gg="git branch | tr -d \* | sed '/->/d' | xargs git grep --line-number"
alias gga="git branch -a | tr -d \* | sed '/->/d' | xargs git grep --line-number"

function gbC () {echo $(git_current_branch) | pbcopy}

# https://github.com/junegunn/fzf/wiki/examples#git
function gcoff () { 
    # git checkout fuzzy finder
    local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all |
        grep -v HEAD     |
        sed "s/.* //"    |
        # sed "s#remotes/[^/]*/##" |
        sort -u          |
        awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
        fzf-tmux -- --no-hscroll --ansi +m -d "\t" -n 2 \
        --preview "git log -20 --pretty='(%cr) %s <%an> -%d' --abbrev-commit {2}" \
        --preview-window "up") || return
    git checkout $(echo "$target" | awk '{print $2}')
}

function gmff () { 
    # git merge 
    local TOCHECKOUT=$(git branch -a | fzf-tmux)
    TOCHECKOUT=${TOCHECKOUT// /}
    git merge $TOCHECKOUT
}

function gcocff () {
    # git checkout commit
    local commits commit
    commits=$(git log --all --pretty=oneline --abbrev-commit) 
    commit=$(echo "$commits" | fzf-tmux --tac +s +m -e) 
    git checkout $(echo "$commit" | sed "s/ .*//")
}

function gcpff () {
    local commits commit
    commits=$(git log --all --pretty=oneline --abbrev-commit) 
    commit=$(echo "$commits" | fzf-tmux --tac +s +m -e) 
    git cherry-pick -x $(echo "$commit" | sed "s/ .*//")
}

function gvff () {
    # git view commit in vim 
    local REVISION=$(git log --pretty=oneline --abbrev-commit |
    fzf-tmux | cut -d ' ' -f 1)
    echo $REVISION
    git show $REVISION
}

function gsff () {
    git status -s | fzf-tmux | cut -c4-
}

function gaff () {
    git add $(gsff)
}

function gdff () {
    git diff $(gsff)
}

function gitlab () {
    local GITLAB_URL="$(grso | rev | cut -c 5- | rev)/blob/$(git_current_branch)/$(fzf)"
    echo $GITLAB_URL copied to the clipboard
    echo $GITLAB_URL | pbcopy
}

function getTrackingRemote() {
    branch=`git name-rev --name-only HEAD`
    if [[ $(git config branch.$branch.remote) ]]; then
        git config branch.$branch.remote
    else
        echo origin
    fi
}

function glomd1 () {
    # git log to markdown
    local urlPre=$(git remote show $(getTrackingRemote) | grep Fetch | cut -d' ' -f 5 | sed 's/\.git//')"/commit/"
    local repo=$(echo $urlPre | rev | cut -d'/' -f 3,4 | rev)
    echo "$repo -> $(git_current_branch)"
    git log --reverse --format=format:"- [%s]($urlPre%H)" -1
}

function glomd () {
    # git log to markdown
    local nCommits=$((0-1+$1))
    # echo $nCommits
    local repoUrl=$(git remote show $(getTrackingRemote) | grep Fetch | cut -d' ' -f 5 | sed 's/\.git//')
    local repo=$(echo $repoUrl | rev | cut -d'/' -f 1,2 | rev)
    local latest=$(git log -1 --format=format:"%H" | head -n 1)
    local earliest=$(git log --format=format:"%H" --reverse $nCommits | head -n 1)
    local urlCompare="$repoUrl/compare/$earliest...$latest"
    local urlBranch="$repoUrl/commits/$(git_current_branch)"
    echo "$repo -> [$(git_current_branch)]($urlBranch) [(compare changes)]($urlCompare)"
    git log --reverse --format=format:"- %s" $@ | tail -n +1
}

function gloc () {
    # git log compare 
    # gloc -5 branch1 branch2 branch3...
    local originalBranch=$(git_current_branch)
    local nCommits=$1
    shift
    for branch in $@
    do
        echo $branch
        git checkout -q $branch
        git log --format=format:"%Cblue%ar%Creset %s" $nCommits | cat -n
        echo ""
    done
    git checkout -q $originalBranch
}


function ggrb() { 
    # git rebase same branch from origin
    git fetch origin 
    git rebase origin/$(git_current_branch)
}

function ggrbm {
    # git rebase master on origin and then rebase this branch on master 
    # used for branches containing machine-specific changes that don't get pushed
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

function g.() {
    ref=""
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git name-rev --name-only --no-undefined --always HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
        ref="$(command echo ${ref#refs/heads/})"
    fi
    echo "$ref"
}

function glogcp () {
     git log --format=format:"%H" --reverse $@ | xargs
}

function viman () {
    vim -c "Man $1 $2" -c 'silent only'
}

alias git-branch-ordered="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname) %(committerdate) %(authorname)' | sed 's/refs\/heads\///g' | head -n"
alias gpad='echo "➜ git checkout atmire-DEV" && git checkout atmire-DEV && echo "➜ git fetch" && git fetch && echo "➜ git pull" && git pull && echo "➜ git merge --no-edit -" && git merge --no-edit - && echo "➜ git push origin atmire-DEV" && git push origin atmire-DEV && echo "➜ git checkout - " &&git checkout -'
alias gpm='echo "➜ git checkout master" && git checkout master && echo "➜ git fetch" && git fetch && echo "➜ git pull" && git pull && echo "➜ git merge --no-edit -" && git merge --no-edit - && echo "➜ git push origin master" && git push origin master && echo "➜ git checkout - " &&git checkout -'

alias echopath="echo $PATH | tr -s ':' '\n'"
alias grep="grep --color=auto"
alias remote_debug_java_opts_on='export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xmx512m -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5010"'
alias remote_debug_java_opts_off='export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xmx512m"'
alias npm-exec='PATH=$(npm bin):$PATH'
# alias tmux="TERM=screen-256color-bce tmux"
alias tmux="TERM=screen-256color tmux"

alias -g C="| pbcopy"
alias -g D="| tr -d '\n'"
alias -g F="| fzf"
alias -g G="| grep"
alias -g H="| head -n"
alias -g J="| jq '.'"
alias -g L="| less"
alias -g M="| most"
alias -g N="> /dev/null 2> /dev/null"
alias -g T="| tail -n"
alias -g X="| tidy -xml -q -i"

# ag "pattern" avim 
alias -g avim="--vimgrep > /tmp/q && vim -q /tmp/q"

# docker build -t vim-antoine .
#alias v='docker run -ti --rm -v $(pwd):/home/developer/workspace vim-antoine'


function findmod() {
    find $1 -type f -exec stat --format '%Y :%y %n' "{}" \; | sort -nr | cut -d: -f2-
}

function history_stats() {
    history | cut -c 8- | grep "^$1" | cut -f 1 -d " " | sort | uniq -c | sort -bgr 
}
