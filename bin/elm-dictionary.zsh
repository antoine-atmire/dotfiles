#!/usr/bin/env zsh

setopt EXTENDED_GLOB
grep "^\s*\w\+[^=]*=\s*$" ~/.elm/0.19.0/package/(^(tests|test|virtual-dom|Internal)/)#*.elm \
    | grep -v "^\s--" \
    | grep -v "\s*type\s" \
    | sed -e 's/=.*//' -e 's/\.elm: */\./' \
    | cut -d' ' -f 1 \
    | rev \
    | cut -d'/' -f 1 \
    | rev \
    | sort
