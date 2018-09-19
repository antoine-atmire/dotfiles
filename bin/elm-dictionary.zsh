#!/usr/bin/env zsh

setopt EXTENDED_GLOB
grep "^\s*\w\+\s*=" ~/.elm/0.19.0/package/(^(tests|test|virtual-dom|Internal)/)#*.elm \
    | sed -e 's/ //g' -e 's/=.*//' -e 's/\.elm:/\./' \
    | rev \
    | cut -d'/' -f 1 \
    | rev \
    | sort
