#!/usr/bin/env zsh
# snippets for expansion anywhere in the command line
# taken from https://github.com/willghatch/zsh-snippets
#
# use: add-snippet <key> <expansion>
# then, with cursor just past <key>, run snippet-expand

typeset -Ag snippets

snippet-add() {
    # snippet-add <key> <expansion>
    snippets[$1]="$2"
}

snippet-expand() {
    emulate -L zsh
    setopt extendedglob
    local MATCH

    # original:
    # LBUFFER=${LBUFFER%%(#m)[.\-+:|_a-zA-Z0-9]#}
    # I removed the dot to trigger the 'date' snippet after dspace.log.date
    LBUFFER=${LBUFFER%%(#m)[\-+:|_a-zA-Z0-9]#}
    LBUFFER+=${snippets[$MATCH]:-$MATCH}
}
zle -N snippet-expand

help-list-snippets(){
    local help="$(print "Add snippet:";
        print "snippet-add <key> <expansion>";
        print "Snippets:";
        print -a -C 2 ${(kv)snippets})"
    if [[ "$1" = "inZLE" ]]; then
        zle -M "$help"
    else
        echo "$help" | ${PAGER:-less}
    fi
}
run-help-list-snippets(){
    help-list-snippets inZLE
}
zle -N run-help-list-snippets

bindkey '^j' snippet-expand

# set up some default snippets
snippet-add date        '$(date +"%Y-%m-%d")'
snippet-add dslog       '$DSDEVBASE/$DSNAME/dspace/log/dspace.log.$(date +"%Y-%m-%d")'
snippet-add 'D'         '2> /dev/null | docker exec -i $DSNAME psql -v ON_ERROR_STOP=1 -U dspace dspace6'
snippet-add skiptests   '-Dmaven.test.skip=true'
snippet-add tls12       '-Dhttps.protocols=TLSv1.2'
snippet-add gtag        'git tag -a "v" -m "v"'
snippet-add 8888        '-L 8888:localhost:8080'
snippet-add gsff        '$(gsff)'
snippet-add sed         'sed -i '"''"' "s|||g" **/pom.xml'
