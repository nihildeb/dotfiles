#!/usr/bin/env bash

# Set my editor and git editor
## VIM
case $OSTYPE in
  darwin*)
    export EDITOR="/usr/local/bin/mvim -v -f"
    export VISUAL="/usr/local/bin/mvim -v -f"
    ;;
  *)
    export EDITOR="vim"
    export VISUAL="vim"
    ;;
esac

alias vi=$EDITOR
alias vim=$EDITOR

