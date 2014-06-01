#!/bin/bash

export DOTFILES_HOME="$HOME/.dotfiles"

dot () 
{ 
    about 'echo dotfiles path';
    group 'dotfiles';

    echo $DOTFILES_HOME
}

cdot() {
    about 'change to dotfiles dir';
    group 'dotfiles';

    pushd $(pwd)
    cd $(dot)
}

dotsrc() {
  source "$HOME/.bashrc"
}



