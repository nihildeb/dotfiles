export PS1='\h:\w\[\033[32m\]$(__git_ps1) \[\033[0m\]$ '

## VIM
# Not Mac
#export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim -f"
# Mac
export EDITOR="/usr/local/bin/mvim -v -f"
export VISUAL="/usr/local/bin/mvim -f"

alias vi=$EDITOR
alias vim=$EDITOR

export HISTCONTROL=ignoredups
export HISTFILESIZE=1000
export HISTSIZE=1000

# disable flow control if in a terminal (i use ctrl-s in vim)
[ -t 0 ] && stty -ixon

# OSX terminal highlighting for ls
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# redhat/fedora workaround, we're not all GUItards
unset SSH_ASKPASS

# GRC colorizes nifty unix tools all over the place
if $(grc &>/dev/null) && ! $(brew &>/dev/null)
then
  source `brew --prefix`/etc/grc.bashrc
fi
