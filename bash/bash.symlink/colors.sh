#!/usr/bin/env bash

GRC=`which grc`
if [[ -n "$GRC" ]]; then
  alias colourify="$GRC -es --colour=auto"
  alias configure='colourify ./configure'
  alias diff='colourify diff'
  alias make='colourify make'
  alias gcc='colourify gcc'
  alias g++='colourify g++'
  alias as='colourify as'
  alias gas='colourify gas'
  alias ld='colourify ld'
  alias netstat='colourify netstat'
  alias ping='colourify ping'
  alias traceroute='colourify /usr/sbin/traceroute'
fi


if [ $(uname) = "Darwin" ]; then
  export CLICOLOR=YES
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
else
  alias ls='ls --color'
fi




