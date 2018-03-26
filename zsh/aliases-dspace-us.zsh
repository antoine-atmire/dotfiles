autoload -U +X bashcompinit && bashcompinit

# ds-scripts by the us
[ -f ~/.aliases ] && source ~/.aliases 

alias -g D="2> /dev/null | docker exec -i $DSNAME psql -v ON_ERROR_STOP=1 -U dspace dspace6"

